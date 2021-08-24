Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F050A3F61E7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238559AbhHXPoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238647AbhHXPoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:44:14 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D119FC0617AF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 08:43:29 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id m28so170018lfj.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=822Hg/zQKXlZynQ1+LBiGkBeYND5KDukoOwmd2Fca1M=;
        b=gR9zHjSevUTGeVgjWogjvaVGn9pr2qT4Vc6+Yt3OuBJ/I68hKvsCnqrIAlreoyOJPz
         gA6Jo+cKG3ncQb7whxm0NNw9Yi8nWwZFZJWY9Y58AzFSMt8HKtd13EE6ad+FugIzpHD+
         qP1FFcxKNlfQOS6KsosGt6rEyKmWxzx6GQU2nQsF2R9jV+4xEHV1cclinLOecSykHStr
         Rg1qG9o0RCI0chY7/69PskPKVKrv3IBHUSGX1jsnHsijSi/q7yS9cCMXND0Gj18o/PII
         rU2r+UlSQ5gMlw3W6c70MyYboZtn6XgBKr/Z3AOzjr7Mx8X8l1m5vAl+DcLggaNE9iwr
         ahbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=822Hg/zQKXlZynQ1+LBiGkBeYND5KDukoOwmd2Fca1M=;
        b=OR55I5KNMawHO+MyNmJoIR6zeSwaE3u7yw0ltw7nUoSfSJr65zTb3CWWbiwn3bSVZT
         4y4iOTDqs+XSXH89cS/eQPKTXRQn1g5X4MCl1YuXhv76iu6NogDjZd2eoyN+oRxPLYiB
         UrCOL6ZuDdH14gKTSqctmeRvJDHi1ADKx9QS7e+PGi+PAlMNPu+KyRWm0NUgNqaQ7fmt
         jrmnILvllVuy1ZFCwUbjL/c4dgWwG24XylQeklNFM45b1skUCFXD/mJ31wUD0OlgKRra
         SfWOSX9Jb9Nff1rhX5wNOKx4KPAzCtHEi4ElZSAiLOWMlCxIavQeEucqlSjz1WnDruzI
         hjDA==
X-Gm-Message-State: AOAM532i9rPxLIZYDfDETmNFhNvrvftCkhGQ8JN0C6xjnswCZZ64fCyR
        rPm7QBmkyXYJ9h1EXSJYg4k=
X-Google-Smtp-Source: ABdhPJw5teytKpr2hE7vg6p4e1EaFdts3r8hfFLR4GzPioV4ATVxFy9juwmdgMWumLP03pT3KsJQRA==
X-Received: by 2002:a05:6512:368c:: with SMTP id d12mr27391742lfs.64.1629819808212;
        Tue, 24 Aug 2021 08:43:28 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id l28sm764654lfj.202.2021.08.24.08.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 08:43:27 -0700 (PDT)
Subject: Re: [PATCH 2/2] staging: r8188eu: Make some clean-ups in
 usbctrl_vendorreq()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20210824142823.16845-1-fmdefrancesco@gmail.com>
 <3740714.KPokl01s95@localhost.localdomain>
 <17234f07-debc-5b6c-244d-472a3f33bc3f@gmail.com>
 <2327592.S5L5zkRU50@localhost.localdomain>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <a5bfab84-16cc-52ad-5cdb-038765bf0b36@gmail.com>
Date:   Tue, 24 Aug 2021 18:43:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <2327592.S5L5zkRU50@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 6:39 PM, Fabio M. De Francesco wrote:
> On Tuesday, August 24, 2021 5:26:23 PM CEST Pavel Skripkin wrote:
>> I found the problem:
>> 
>> >  	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
>> >  
>> >  	/*  Acquire IO memory for vendorreq */
>> > -	pIo_buf = dvobjpriv->usb_vendor_req_buf;
>> > +	io_buf = dvobjpriv->usb_vendor_req_buf;
>> 
>> 
>> I don't know from where mutex_lock() comes from. In staging-next I have
>> 
>> _enter_critical_mutex(&dvobjpriv->usb_vendor_req_mutex, NULL);
>> 
>> instead of
>> 
>> mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
>> 
> Oh, I know where it comes from... :)
> 
> It's a patch of mine that is in the queue, waiting to be reviewed and applied.
> Please see: https://lore.kernel.org/lkml/20210819221241.31987-1-fmdefrancesco@gmail.com/
> 


oh.... there are _a lot_ of pending changes :)

I guess, we need smth like public-mirror with already reviewed and 
working changes




With regards,
Pavel Skripkin
