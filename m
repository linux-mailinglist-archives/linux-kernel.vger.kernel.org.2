Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2E443C64C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 11:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240014AbhJ0JR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 05:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237410AbhJ0JR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 05:17:57 -0400
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405C8C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 02:15:32 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1CC1317A1E9;
        Wed, 27 Oct 2021 09:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1635326129; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references;
        bh=qtMW8hCsVX/dXREV1Ln1udYFLipXUwFym8N+KBq39DE=;
        b=nDkM/h4MIGrx6s9ej7ZR5C7dwH8M8kmJ6RSrTyycYR667H5Jaq1kf1+Vuz/kpb606Nr4qk
        BE//r8oXNWq8bTrdZJSCH5wIfSJFLiU9HGRTKQyjZbKsGGGaNvPugjTKNnYFM4fIjkkbKi
        yzOMjtiOIHD5g1i+kLNZtaej7Iy0EQUgDoEsCzsrbsITu0zlLR/gWzx2mdyYAHOnAeVe+S
        I2KII+6YB+1Wm4nA9gx1Khr834m1wyN5lZiOjTSahA8w+ujQM4hZVYgy5i+mB+mKDoyGOI
        RmAsW7mU0vCv6xe9i8ChASoxKF6pf9QXZWQLFzhgRyufxCoM2mYIzqhHBxvfLg==
Message-ID: <19776e09-59ed-9f46-aeb0-9ad017e79a68@lexina.in>
Date:   Wed, 27 Oct 2021 12:15:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2 0/2] Bluetooth: hci_h5: btrtl: Add support for
 RTL8822CS hci_ver 0x08
Content-Language: ru
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211025084704.173755-1-adeep@lexina.in>
 <53EA5BEB-8D36-480E-9FB7-A3F49FFB3CFF@holtmann.org>
From:   Vyacheslav <adeep@lexina.in>
In-Reply-To: <53EA5BEB-8D36-480E-9FB7-A3F49FFB3CFF@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. Aligned to bluetooth-next.

25.10.2021 16:06, Marcel Holtmann wrote:
> Hi Vzacheslav,
> 
>> Add a variation of RTL8822CS with hci_ver = 0x08. This is fully similar to RTL8822CS with hci_ver = 0x0a
>> The controller does not always start when the system starts up, so we do a forced reset via gpio during initialization.
>>
>> Changes from v1:
>> - remove Signed-off-by chbgdn <chbgdn@gmail.com> as not reachable
>>
>> Vyacheslav Bocharov (2):
>>   Bluetooth: btrtl: Add support for RTL8822C hci_ver 0x08
>>   Bluetooth: hci_h5: Add power reset via gpio in h5_btrtl_open
>>
>> drivers/bluetooth/btrtl.c  | 7 +++++++
>> drivers/bluetooth/hci_h5.c | 5 +++++
>> 2 files changed, 12 insertions(+)
> 
> the patches don’t apply cleanly against bluetooth-next tree.
> 
> Regards
> 
> Marcel
> 
