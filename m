Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D10C3E877C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 03:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbhHKBDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 21:03:02 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:53907 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhHKBDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 21:03:01 -0400
Received: by mail-pj1-f43.google.com with SMTP id j1so790818pjv.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 18:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7NTG/vEAVW33QwSz6IbOwW37gh6DXGDFaf8xH4NDYdc=;
        b=YCIBIQs0R5CQeHwjbZ/VucHAloRKWZX6I6IQayJ2+cNNsdQKOcxC4E6H+RSPUqmenb
         5wJpmd//VlAr2msc1SqYp/+jbNTSVRf5xOgANrIL+pjuL0zNenBDN+rrm8FJYaZ0xcQO
         jJCboetIfViQ4eLrjnWI4XTS9FKNJ7QNhBYZ0Xu9c9NAetpncX6iHmtaU19sxRwjEZnA
         UHywN6uexiTHA2l8ylVq+sETNc30t8jm7nHllccpC9d/Qwam3UbUC/bOTMdl9p4dc8Zy
         ONdRJ9/oBefpCY74mxuiVqjZgkArS5ounvjXme4VzJEWfk16sESRIT3YqOltSh7A0pjg
         BeKw==
X-Gm-Message-State: AOAM532wTlDQaC5j6Z0Vx/UgaaGYofG7PeVhjDf1giX8K4d69MA7IpBn
        53bG4/IT7Ox9mKopeF7gejo=
X-Google-Smtp-Source: ABdhPJy2Q/BoFQTa/ia3PdlVLFKaI4IXuMZ9P7J56R+D6rerGlNeIsQ+ZX02SDqDxFOQGEVaj2KxaA==
X-Received: by 2002:a63:83c7:: with SMTP id h190mr111482pge.51.1628643758343;
        Tue, 10 Aug 2021 18:02:38 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:61e5:4b9f:b48a:e987? ([2601:647:4802:9070:61e5:4b9f:b48a:e987])
        by smtp.gmail.com with ESMTPSA id y6sm23014351pjr.48.2021.08.10.18.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 18:02:37 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: Do not reset transport on data digest errors
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, yi.he@emc.com
References: <20210805121541.77613-1-dwagner@suse.de>
 <47ef76c6-4430-ca24-405e-a226d4303a39@grimberg.me>
 <20210809090947.luoqaooi7gc6u6yu@carbon>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2e91c065-d3c6-1bef-5906-1a4648368894@grimberg.me>
Date:   Tue, 10 Aug 2021 18:02:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809090947.luoqaooi7gc6u6yu@carbon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi Sagi,
> 
> On Fri, Aug 06, 2021 at 12:42:00PM -0700, Sagi Grimberg wrote:
>>> @@ -89,6 +89,7 @@ struct nvme_tcp_queue {
>>>    	size_t			data_remaining;
>>>    	size_t			ddgst_remaining;
>>>    	unsigned int		nr_cqe;
>>> +	u16			status;
>>
>> Why is this a queue member and not a request member?
> 
> I was not sure if the TCP transport specific error handling should
> impact all other transport (size of struct request). Also I tried to
> avoid accessing cachelines which are not already in use. Except this I
> don't see there should be no problem to put this to struct request.

It is the correct place, lets see that it doesn't increase the struct.
