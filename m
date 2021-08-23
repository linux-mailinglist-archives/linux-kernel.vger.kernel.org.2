Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985CF3F4F23
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhHWROw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:14:52 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:43613 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbhHWROc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:14:32 -0400
Received: by mail-ej1-f51.google.com with SMTP id ia27so16289564ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KLZj2LD1i0UAf3+bazXB1vSdaKBKru5JF9BniV7Zb3w=;
        b=p8aPUjrQriyI/ifxr/BFaTj4VFW0lIJ+qbyHQN/j24vK6ecuqME0mczTlZYU2CffE+
         CU+JRBH8YcGsgIADf7bsZk5w0rcdC0BWpZiAqqRNjsOdkuDorufj1cdLpALV1cyhsiOY
         /NlzcFsVVpuvv+zjeSPpzBJPzng2dVSmcbiQDKtFtfcxYTe6XanmwOz1Uorh+H8Wsx0P
         c43lQbPWEOtzHE5nCf6gTm3ioPEKJvoHsE3RmoASewZMQ5n79UweZL3xMLXKuV+xTLTB
         lALnv1XIjJKtKLFIndWTCviGAmVx1tpJ0Xb115JMVim3cyyzj7vNY2GtmZcG3pBnfJCX
         E00Q==
X-Gm-Message-State: AOAM530v4tStt7z1nobv2oUsjUMqZ3fJD8HXpy2y7a0MiEWTlzkpl3fk
        jwxSAZg74IsH0v0G7sIb3SA=
X-Google-Smtp-Source: ABdhPJxGlVGrMM0SewYur5DWk57X2CIFzmM8l1Z0YtDg55QEYBhtj4Sflcy+/5r4HO9pIobBhO0cgQ==
X-Received: by 2002:a17:906:9b87:: with SMTP id dd7mr34850343ejc.99.1629738828966;
        Mon, 23 Aug 2021 10:13:48 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il. [109.186.228.184])
        by smtp.gmail.com with ESMTPSA id dg24sm9773808edb.6.2021.08.23.10.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 10:13:48 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: Do not reset transport on data digest errors
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, yi.he@emc.com
References: <20210805121541.77613-1-dwagner@suse.de>
 <47ef76c6-4430-ca24-405e-a226d4303a39@grimberg.me>
 <20210809090947.luoqaooi7gc6u6yu@carbon>
 <2e91c065-d3c6-1bef-5906-1a4648368894@grimberg.me>
 <20210811103146.ytqj5mqpioiba56x@carbon.lan>
 <20210818124430.hokmfa25lnhxnswu@carbon.lan>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3ffb2ff9-0074-7f3e-6c40-18837c0a02d7@grimberg.me>
Date:   Mon, 23 Aug 2021 10:13:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210818124430.hokmfa25lnhxnswu@carbon.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> It is the correct place, lets see that it doesn't increase the struct.
>>
>> It should not according pahole:
> 
> Anything I need to do to get this patch accepted?

Yes, move the status to nvme_tcp_request, I think its
a more appropriate place for it.
