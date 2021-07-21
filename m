Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4B13D062C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 02:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbhGTXnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 19:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhGTXlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 19:41:51 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BAEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 17:22:29 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id t4-20020a05683014c4b02904cd671b911bso569208otq.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 17:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G9TO+iZ7Ir53u9Gh/j26vGhpLzZM6SVZZgf+lWvR/pE=;
        b=F7rWQqe4K8cpd1wP5r+PFJze8wRJ43Q/KfBeI8Y/63gRnVw9a/EjlaumUrfRstm0hX
         NCfReDydysSJP9cGiDHpplyXYdaOxNfmt3orCAPgayRxA452BPLQ/63i+svAJKK+Ccnh
         H1HBZj/WPbjm9k19KtlaPwE1TgQ7lrDVddZwmbJg+WUWspudLlN3D6N7SailwBEvU/Sp
         YNB4ksyMblJEKfWtfpyFQOzwlvjwdY49P7veoFOwQGtoY4P3HvVV36Nn5+MsSmvJtfjS
         n9Ape0Euw3JUfmxWRqNg3hmPil1yAp5yUo4zAIT7/CMB6mx39sq25lXt/AkTGuLYJYlw
         AVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G9TO+iZ7Ir53u9Gh/j26vGhpLzZM6SVZZgf+lWvR/pE=;
        b=c6Gm3qAdCHy8LPCuLdvwLuUXR7W8jYNAc3GBR7FC2P4K5liPdrMpUdPXmlLAPhCNKS
         BwZw6VhMoQHgKkIUKlamJa9HQeCEfhLf7rjWNN4RJK6gXpdT8uqaCumxdMDtUB3Ohw0y
         dv4Xl1dXamJ/Kto6leSBn03yKmwm9fZQCxeuLmLGECnlyi/TyO5iXyEVTKKWrvkXYJZ/
         P6ZKSwnP/JUFS4kdxNRUF1RsIlH1ThkpehQCw42VYc+a6yOAhJbEnoiRGt868zFgTgNW
         DQGUxXtyC+4OuMEFLM3GT1FAH2S/NTEgeh8ZSf6h9kYCndPyU19KuYKSLAdB8oT0WKq4
         edoA==
X-Gm-Message-State: AOAM532wwjccRin7yH4pXtAAU2eoQFcHrcXpLPnbh2WNEZWbnW0N7rbJ
        5pJINI9Y05HdMWO1tqwnATo=
X-Google-Smtp-Source: ABdhPJwRIpApJ1EXCXjB+f0uM611tDA5JGFduBOALAFTgFcvlM4BoGq5VZJSfHp5gEvBeFaeqjG6IA==
X-Received: by 2002:a05:6830:1c65:: with SMTP id s5mr18764814otg.256.1626826948826;
        Tue, 20 Jul 2021 17:22:28 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id x22sm662479oie.28.2021.07.20.17.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 17:22:28 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH resend] staging: rtl8188eu: move all source files from
 core subdirectory
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <20210719224601.255364-1-phil@philpotter.co.uk>
 <7bc43fb0-2dab-190b-c480-9e77cff863d4@lwfinger.net>
 <20210720090035.GB1406@agape.jhs>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <08a8b372-8ec2-afcc-cc54-305d1dd74a59@lwfinger.net>
Date:   Tue, 20 Jul 2021 19:22:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210720090035.GB1406@agape.jhs>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/21 4:00 AM, Fabio Aiuto wrote:
> maybe the information we will need one day is:
> 
> will the core/-os_dep/-hal/-include/-directory-structure be
> welcomed in mainline wireless subsystem, when an rtl* driver
> will be perfectly tuned?
> 
> At the moment I can't see such a directory organization
> in any of the realtek wireless driver.
> 
> Sure there's time for that;),

The question is how much lipstick do you want to put on that pig? The current 
version does not use cfg80211, and it does not work with NetworkManager or a 
modern hostapd to create an AP.

If you want to get the rtl8188eu driver in shape to be added to the regular 
drivers section, then I suggest you start with the v5.2.2.4 branch of 
https://github.com/lwfinger/rtl8188eu.git. Many users of the RTL8188EU chip use 
that driver. At least that version fixes the two problems listed above. If you 
want to flatten the directory structure, you can do it there and offline.

I want to caution you that following this path will take a lot of time, but once 
you get it into kernel shape, it will at least be useful. I have never had the 
time, nor the ambition to undertake this effort.

Larry

