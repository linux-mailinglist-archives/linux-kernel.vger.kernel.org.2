Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45829339F61
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 18:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbhCMRK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 12:10:59 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:45015 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbhCMRKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 12:10:36 -0500
Received: from [192.168.100.1] ([82.142.6.26]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M9W78-1lOPZa2VAy-005Wlq; Sat, 13 Mar 2021 18:10:30 +0100
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
References: <20210309224313.956065-1-laurent@vivier.eu>
 <20210311104414-mutt-send-email-mst@kernel.org>
From:   Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] virtio-mmio: read[wl]()/write[wl] are already
 little-endian
Message-ID: <a8a0b68c-d36d-c675-3c6d-d4fca996fdfd@vivier.eu>
Date:   Sat, 13 Mar 2021 18:10:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210311104414-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:G08HK1guKjHRwbQpgdUdeh/SBJgQzzMRgVbO7cqqd82ltaiH3Ty
 04xGxzPbJiJSs0gI6xlVwqlwrsz1JGZyv8+LgKSvG+HiRAVlqHJl7ggO4bmlBnudrFf96YM
 qWIAL5/KCkQVsxHwj2zjP3v2VZLt2/bZ52suFTcJ4eOhoT7rcq0NagNM8++8ssSOCnqVHfF
 kpvHegM4Eo2GqxuVk/C1A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3M2gSXfPJ+Y=:hBaGSLJpV9DMK9DMzLOgj1
 Vu3HNh2RX5AG66JzNXwCaSepr+2Z6qlsc0lKT++u860IpP5nU2hAw97OpUZfdKzaSmHoaAqWo
 4NywPr/9z1Ah5Bam2KljbgaIukCMDvaiGjgWBVTLaX42kH7eKnOGG5HRTRY3L1IL3AMMLpomh
 DZxdb0g8Bu5bB6yDFImjt/9WD5hXTQibeTPVDMaiICCNhnRbdvXwDRki++OEdNNHr4ImUz4eg
 v7NRa3l3otsDDLGr9JV/AVwpMVid1mfJix2HpqH9wUZk+apewK6daIMnhB8yR90h5+yf84DSv
 sJ1sX0R/qfN56mrS/5I7jDVScpUYQcXttlpwbZDp5g+a5KLnJlLcEwvoQZAectimr0lNLASE8
 zZGvfTiC/JjTTblXHwhQ4AmaA8r6Kz7Feme3i9NHhNF2s84/huAM5rwGMSA8THDS0D7+Wd8cJ
 KTP5VB1Z8A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 11/03/2021 à 16:44, Michael S. Tsirkin a écrit :
> On Tue, Mar 09, 2021 at 11:43:13PM +0100, Laurent Vivier wrote:
>> read[wl]()/write[wl] already access memory in little-endian mode.
> 
> But then they convert it to CPU right? We just convert it back ...

In fact the problem is in QEMU.

On a big-endian guest, the readw() returns a byte-swapped value, This means QEMU doesn't provide a
little-endian value.

I found in QEMU virtio_mmio_read() provides a value with byte-swapped bytes.

The problem comes from virtio_config_readX() functions that read the value using ldX_p accessors.

Is it normal not to use the modern variant here if we are not in legacy mode?

I think we should have something like this in virtio_mmio_read (and write):

--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -112,15 +112,28 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)

     if (offset >= VIRTIO_MMIO_CONFIG) {
         offset -= VIRTIO_MMIO_CONFIG;
-        switch (size) {
-        case 1:
-            return virtio_config_readb(vdev, offset);
-        case 2:
-            return virtio_config_readw(vdev, offset);
-        case 4:
-            return virtio_config_readl(vdev, offset);
-        default:
-            abort();
+        if (proxy->legacy) {
+            switch (size) {
+            case 1:
+                return virtio_config_readb(vdev, offset);
+            case 2:
+                return virtio_config_readw(vdev, offset);
+            case 4:
+                return virtio_config_readl(vdev, offset);
+            default:
+                abort();
+            }
+        } else {
+            switch (size) {
+            case 1:
+                return virtio_config_modern_readb(vdev, offset);
+            case 2:
+                return virtio_config_modern_readw(vdev, offset);
+            case 4:
+                return virtio_config_modern_readl(vdev, offset);
+            default:
+                abort();
+            }
         }
     }
     if (size != 4) {

And we need the same thing in virtio_pci_config_read() (and write).

And this could explain why it works with virtio-pci and not with virtio-mmio with the big-endian guest:

with virtio-pci the bytes are swapped twice (once in virtio-mmio and then in virtio-pci), so they
are restored to the initial value, whereas with direct virtio-mmio they are swapped only once.

Thanks,
Laurent
