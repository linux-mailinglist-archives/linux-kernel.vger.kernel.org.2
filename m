Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9C44415E2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 10:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhKAJOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 05:14:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53302 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231320AbhKAJOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 05:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635757891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=2W7P6GktRsi14ktbeTR+//wKtS91dY+AJDqQY5GsUpU=;
        b=TD5x0RfdqMgSopo/4pCBy+doK9o4f5CnOSswGfvyZMITPACsFrlclNiPBUeWsblNIWpeW6
        UZDV190wznVyieQG2Ze9L2E7FXFOAQzTtY8EgvEgf57k2bADTPWoH3W4zIdYBV00+YWYhK
        lIWMEP37eF9dlwYAVF/NodA8uyHdUTg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-CLKLed9fP76WLz8e_zNSAg-1; Mon, 01 Nov 2021 05:11:30 -0400
X-MC-Unique: CLKLed9fP76WLz8e_zNSAg-1
Received: by mail-ed1-f72.google.com with SMTP id f4-20020a50e084000000b003db585bc274so14920708edl.17
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 02:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2W7P6GktRsi14ktbeTR+//wKtS91dY+AJDqQY5GsUpU=;
        b=b32uIGljal1JuboG+WWOljwqMKkujtSmQRfGY+fE8rG9NFxm/6at/f9TWSRQSA3kW5
         yvqZEvM1L/za1K6/+d7TOS7LIpbl0U13QOZjnt98GW5QDISTB+o1+s80bw6kpLI7LtbD
         +fGlwflMD77OUDT/RB1om6pSUbFseTg4st5tJE39ckSu8BrUe5qgG4WBhF8G6bvjdOyI
         /6iWGs1c4rICw9XKTKLeZopvheyG9ypb1l0HY7hOqBkpFk+sJLKeIHQcmYrtOdylR4R4
         I/MvRgBrqNw+vtUlyIwNtJwnWVMHxNa07u5yif2ZCQfgyQLz1WSr+29bjS43vuZ4AcuN
         1pFg==
X-Gm-Message-State: AOAM532A+h+DkYYut9lOhOsO/aKjhf0NUR3UE80bYq2eHsLpjqT/q2PV
        A2OzAznYqXONq3aW0C42uA3jHYBf+bwFpGqbDThXY+gBEvytkJ5/U0LPUlrmcMMzIsyPcOI0bNc
        LY14gZdTpk/cSjS9huRX5Liko6kPnf67RdJlwdEsWSR02j5+TW5SaF86QgYQtQcrHYEisTA==
X-Received: by 2002:a17:907:7215:: with SMTP id dr21mr16826624ejc.505.1635757888613;
        Mon, 01 Nov 2021 02:11:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGFjVuS5ieqvbfX0iqQUSp1YKsugqWB3cvdDo7TtxlMqzMZiJotDXzX2Nh2NnX9BU8QL6UDA==
X-Received: by 2002:a17:907:7215:: with SMTP id dr21mr16826599ejc.505.1635757888385;
        Mon, 01 Nov 2021 02:11:28 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:107f:7087:907d:ff12:1534:78b7])
        by smtp.gmail.com with ESMTPSA id g12sm2377939edz.68.2021.11.01.02.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 02:11:27 -0700 (PDT)
Date:   Mon, 1 Nov 2021 05:11:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>,
        Jason Wang <jasowang@redhat.com>, linux-gpio@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio_gpio: drop packed attribute
Message-ID: <20211101091122.442512-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declaring the struct packed here is mostly harmless,
but gives a bad example for people to copy.
As the struct is packed and aligned manually,
let's just drop the attribute.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_gpio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_gpio.h b/include/uapi/linux/virtio_gpio.h
index 0445f905d8cc..25c95a034674 100644
--- a/include/uapi/linux/virtio_gpio.h
+++ b/include/uapi/linux/virtio_gpio.h
@@ -25,7 +25,7 @@ struct virtio_gpio_config {
 	__le16 ngpio;
 	__u8 padding[2];
 	__le32 gpio_names_size;
-} __packed;
+};
 
 /* Virtio GPIO Request / Response */
 struct virtio_gpio_request {
-- 
MST

