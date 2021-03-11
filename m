Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF19233788F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 16:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhCKPzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 10:55:39 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:39251 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbhCKPze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 10:55:34 -0500
Received: from [192.168.100.1] ([82.142.6.26]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N6JtR-1lnOn21c5p-016g76; Thu, 11 Mar 2021 16:55:29 +0100
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
References: <20210309224313.956065-1-laurent@vivier.eu>
 <20210311104414-mutt-send-email-mst@kernel.org>
From:   Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] virtio-mmio: read[wl]()/write[wl] are already
 little-endian
Message-ID: <60e83b80-f42b-456a-f37d-b7836e3abe1f@vivier.eu>
Date:   Thu, 11 Mar 2021 16:55:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210311104414-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0Zat+MwnHuiHIsJ6RasX0CpPm68DNDxtPY2t33OP3ELYFeX6KxC
 D2zbenpLenwKw8wfSy+0gBlPWbUz5SfevgQh1FlfsLq+wyrmuCnOlk5Cnjck2pqokxX6Do/
 q+FvWmZUWBCA0m5Y6kYDkj+zhp3wdpartT9Pwktqw7vQsUX6BTgf3d79psEaTsHqH9dVE9Y
 ihV50oO9QIffcC+lFXOEg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LWoVhg73Vfo=:zHaVSVSSPzQKH+rIQNkOzl
 gG+aLV/uCVWUDmUfmezRGb2Riq2JsQOn51uDuX6G8c4tp99JpOiGxMOGo/TLDBftyRf/0CflI
 PEvbmutPoA7ZTyiTljt1vEH/l0mbgfl2AH+U1JfjceVWAzayMPWLx2T3TPlzW4Cj+c2TAM2yw
 trcXiH9MhHzcRs63jzRIcSZ3yq1rcwZjea45KB4zk2kx5tbZrf316DSMQkWWs+sJGbYi3hvBh
 6GqW4q4hTbeG7dMP6DkxH+stGvf81gj8E+nWg+ws8eIrzQGp/2kWetqhYHjrEDhrRY10jhiDn
 gPjpHGPVMsnFP0xuQ2hWwscfN3ocxPEDzpaFd7B+CQ/8lgVHiNBIYmUYUAY1MNIVSWwpjg0xx
 BKNKHMTxlx+ZPcj6+FFkO+znvRuMcUTu94xNpzNv3FU8d+SQE9/E/pF+nnfgku+JafT8RAa75
 Na3GtJohOw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 11/03/2021 à 16:44, Michael S. Tsirkin a écrit :
> On Tue, Mar 09, 2021 at 11:43:13PM +0100, Laurent Vivier wrote:
>> read[wl]()/write[wl] already access memory in little-endian mode.
> 
> But then they convert it to CPU right? We just convert it back ...

Yes, you're right.

But there's a real problem with a big-endian guest using directly virtio-mmio without using virtio-pci.

It seems there is one too many little-endian conversion somewhere, and this has not been detected
before because there is no big-endian guest that uses virtio-mmio directly, and with little-endian
guests the conversion is a no-op. I'm going to have a closer look to the code path... perhaps the
problem is in QEMU not in the kernel.

Thanks,
Laurent
