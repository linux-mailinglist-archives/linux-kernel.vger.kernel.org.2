Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1C03D2798
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 18:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhGVPu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 11:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhGVPu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 11:50:28 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B32C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 09:31:03 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u15so7222156oiw.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 09:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nJqt6aEQhJ62kc2f84CwMWQhZV90rGzZxRgH8SmsqLI=;
        b=qWxhII5/AehtZWRzLBrt0mFlbuJGS2yIl8FlQgcEMued+EsnNnDCzpPof1z0xUAshW
         9S0X1Va2T8ao9zX4eNLH7ZsQ84YlEu76mnoG/BLP8fkqTd/iCSxiWV1iMRpgVj9pbWnD
         Y/GJcsO+hZgLH99pu7eJDftIZ5ZwkP7rxeua7Pu+e/sKTcriOm1iP2btX7jKeURPLOYB
         PA1hUmcUyRW3H5GZmjCjbOz/TXvB5iCAkHk9jWMtW6278op7//4wOkuHg7P/n7KBF4BF
         Wz+Kn9qmzwKh00HhEEfnfNuU829hC/JpMWE+T+WUHbXE3eNEwR6i0OGHZJp6RokJaZbO
         hYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nJqt6aEQhJ62kc2f84CwMWQhZV90rGzZxRgH8SmsqLI=;
        b=o10rw/gUq3lMzUY+oVUp4pZpBAYGBgODk/xj5iGLspGt4b33Xmz85Fz+eHYN568NLL
         tPZ4jnEUUhKPglTRIv1fnRYFRy/8Ef7Z3pvDUHjMbHI0gleZ5iYlzol0VVkCC2bq7Cfn
         huoW1qNLJCcCgShBZlWJegb/fnfanSqhTXkZ++glGzQFUg3vAREGYyZym430LMzUcDcT
         vh3EFDE2JUmU/oGjzaIGNRrU6XjE6mDVlqx212j8pyLJRfg99FWGvQM6HUAQfWn13AWR
         IIqzym9Uu5ZpfO4uJFgGRcuWatCze/Anju5B1kkKvPMoitjNdlh5oRLq3gVrLmu8N5M1
         bxTQ==
X-Gm-Message-State: AOAM5332kdXRHCgFr30om68zAjSX9zj+3YOm85C0+4YaAE6zVb2MQ4h9
        y0vW79i+KapH8W/CVZG/oUg=
X-Google-Smtp-Source: ABdhPJxUicCRZgtL6n1yZmKF06mBJmZ0HR3rAWAfzPvGyrl9ywrK0YKK3vufu56JAxSZMuRHJjd5QA==
X-Received: by 2002:aca:4256:: with SMTP id p83mr6104569oia.70.1626971462350;
        Thu, 22 Jul 2021 09:31:02 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id t141sm4887442oot.40.2021.07.22.09.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 09:31:01 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH resend] staging: rtl8188eu: move all source files from
 core subdirectory
To:     Greg KH <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, Fabio Aiuto <fabioaiuto83@gmail.com>
References: <20210719224601.255364-1-phil@philpotter.co.uk>
 <7bc43fb0-2dab-190b-c480-9e77cff863d4@lwfinger.net>
 <20210720090035.GB1406@agape.jhs>
 <08a8b372-8ec2-afcc-cc54-305d1dd74a59@lwfinger.net>
 <YPfRf8dgFd+u5hzm@equinox>
 <0c2d97fa-e1e1-3564-98b8-37d5b9a1a9cb@lwfinger.net>
 <20210721182836.GX1931@kadam>
 <ed7b7d93-f754-dce9-ca4f-425e49c972ba@lwfinger.net>
 <CAA=Fs0nvhxEhJhCTWH_KkYyB3Jz7Pi-t2a+6zL3K=O-_3-sLGg@mail.gmail.com>
 <YPlyZsuRJpkUwWiJ@kroah.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <e91cf326-f393-4ad5-568a-dbdd7cc759db@lwfinger.net>
Date:   Thu, 22 Jul 2021 11:30:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPlyZsuRJpkUwWiJ@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/21 8:28 AM, Greg KH wrote:
> If the code looks "better", I have no objection to just adding it to
> drivers/staging/ and deleting the existing one here, so that everyone
> can work on this together in one single place.
> 
> Larry, any objection to that?

I am not opposed to that. Do you want me to supply the new driver as a set of 
patches, or would someone else like to do it?

Larry

