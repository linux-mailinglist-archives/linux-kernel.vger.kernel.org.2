Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5936456093
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 17:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhKRQh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 11:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbhKRQhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 11:37:16 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D931C06173E;
        Thu, 18 Nov 2021 08:34:15 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id i194so19707798yba.6;
        Thu, 18 Nov 2021 08:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Oh9ODDDFLRmzNfepThPkjsuExxPNsB2gi+UCiZt5s4I=;
        b=dT15HCZO7fz+oE4UjAWFgomVfqsHerQzrgDkh7fvovPjfMAAMGUo1bEG5OhmYa1IyZ
         PX69G9ivrHzdOxizIONgbFl0+7+ENzXivFsHd2TBr04sgS0PSnBBUd5Ka50ruOTouLaB
         /rFabWScgn5sK4pGWt5DWQ47XLJlgnqSAyFqAKFWy7skLeVVHqlSulWqS52Gf6k3CFkV
         /c0WXISCjH9nSV+WQRx3lJ/xSA59JQZ2uJWXmjtLa8nPMkq7+s5QK+g3cK0AEYyQeycl
         QJqSnbnbGJm1Vk2IR9CyDZUqmLiWwt4m/uJ7Tk/+cduSj4GLU5LzU/NAdwLLALLdrWOG
         sARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Oh9ODDDFLRmzNfepThPkjsuExxPNsB2gi+UCiZt5s4I=;
        b=fB2AsiIXJd5KtAWE9623+pmVMfUeUTDyVqHdTiXv607cK7/d1oA5Kcfsja6Xm0uUS4
         /xKWtDUM5O+sOqGsdmwkmhFzBjOcnOR0/+taqhPPXV1o77RFlzyTyrwir0VpJ9WVPJgO
         Ih7R2rqUw7ABGvavTEh3myvwP02DEd4NqJOkVX3cM35aBkSXJZKikmQj+EiDrrg2xRjz
         +RzUp5ZUyIWbLOXe3FdvH7bRM+xH8zyNlp8VT6/q+ZIGDT3Zb5CCpg3X5WNSVGJJS9zf
         KAr1Dq5fNDuz0J6E60sm4vI4HMANOcuHgdM+98QMRX9JAuXzO6cawkyB7nLoiLvHCJOH
         Sm6A==
X-Gm-Message-State: AOAM533Fz/0BMbJN7e9DFjX/f+fXk9+/Vkti43tHct73z8RtFB+xfN1i
        ncMraA7KrKsKGqqkAM7Gk0HJ6jJ8CeDGp/fT1tVOkFA/L0I=
X-Google-Smtp-Source: ABdhPJxrEJw1OHs98sWXO7Piw0y47LexL2GylnuTlY6IMnCfPeRhf87BCXCA7VCUdANyWiDLKofBJCL2mZAkxMg2+p8=
X-Received: by 2002:a25:d743:: with SMTP id o64mr28709401ybg.81.1637253254713;
 Thu, 18 Nov 2021 08:34:14 -0800 (PST)
MIME-Version: 1.0
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Thu, 18 Nov 2021 22:04:03 +0530
Message-ID: <CAHhAz+i88SYbYTLY4Ti50LBx6cb3yogcjRtQ4rP1HBMei=8uFQ@mail.gmail.com>
Subject: USB: invalid maxpacket 8
To:     linux-usb@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,


I'm trying to connect to a USB device on Linux PC and getting an error
about "invalid maxpacket 8". What does it mean? Does this error causes
USB packet transfer failures?

Any ideas how to fix this?

Thank you for any pointers.


dmesg log:
---------------
[1920549.030669] usb 2-2: New USB device found, idVendor=05c6, idProduct=9500

[1920549.030682] usb 2-2: New USB device strings: Mfr=0, Product=0,
SerialNumber=0

[1920549.032623] hub 2-2:1.0: USB hub found

[1920549.032672] hub 2-2:1.0: 7 ports detected

[1920549.302875] usb 2-2.1: new high-speed USB device number 98 using xhci_hcd

[1920549.391765] usb 2-2.1: config 1 interface 0 altsetting 0 bulk
endpoint 0x81 has invalid maxpacket 8

[1920549.391777] usb 2-2.1: config 1 interface 0 altsetting 0 bulk
endpoint 0x2 has invalid maxpacket 8




-- 
Thanks,
Sekhar
