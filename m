Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92F23D94AC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 19:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhG1RzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 13:55:25 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:53936 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhG1RzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 13:55:22 -0400
Received: by mail-pj1-f43.google.com with SMTP id j1so6335280pjv.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 10:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vaHWQMyapbwMNDooasKS1ZMgjJGMU/Tqpe97r0Mjc8M=;
        b=KnTHJy4j2DE7U9mBziHMHZT+iHLv3pc8XwLSLfXFK5ZeV+R2cEIL3tJ7nqjikhlIOA
         uPpnnNiK4hxhTj3VRDBbf8MJKUrtmpcojMlidB8DEgKSeAOuieuaN4j5XsAAGCN7x/0K
         cisPB1a9xsnCM7ODe4hYU0xXVE4UU2nVcyl3eOX0CCWsdOG5TFkwne5uJmVROJJYbq7i
         vxMpKQI/mzj7CY2cMN9V8NYU/sLrjJGlB7Bml8XH6un+ntYYXcce0lR1NMkbcqu3Cxhf
         5ce5UMn1sjPhtQmQCrc1sX7+Sw9/vUwV2+PBOZAjvLhhT1GP+7McGCHC2PRttU2iaMR7
         9iyw==
X-Gm-Message-State: AOAM533CQ8p+2FBX9641zzlM36joZ++8+jUD5mDdYR0nK/QbVgT/p3Sn
        cOe8RDAUBkUOy++xSMAcWwk=
X-Google-Smtp-Source: ABdhPJwj/v4a358VMS8grMiaN9aSuY7X8fqahL1XIeoeDYXE5xu3N5q77WtvLmLNWd0QLshLVTU3YQ==
X-Received: by 2002:a63:5505:: with SMTP id j5mr93705pgb.250.1627494919816;
        Wed, 28 Jul 2021 10:55:19 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:3328:5f8d:f6e2:85ea])
        by smtp.gmail.com with ESMTPSA id c7sm440015pgq.22.2021.07.28.10.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 10:55:18 -0700 (PDT)
Subject: Re: [PATCH 2/4] configfs: Fix writing at a non-zero offset
To:     Bodo Stroesser <bostroesser@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>,
        Brendan Higgins <brendanhiggins@google.com>
References: <20210723212353.896343-1-bvanassche@acm.org>
 <20210723212353.896343-3-bvanassche@acm.org>
 <7bee65ce-f5f1-a525-c72d-221b5d23cf3e@gmail.com>
 <d12f24b6-7066-f9bb-1b88-6cc23c9c45c1@acm.org>
 <4055ca70-7669-d00d-7c08-86fe75a3d377@gmail.com>
 <618b2bdc-282b-0a1d-1fc5-020cf80d7a7e@acm.org>
 <c9cb1f3b-0b3b-c571-4a51-e647f3c1e90a@gmail.com>
 <ab190c50-8c87-b215-1432-056c81bcd656@acm.org>
 <fec30933-46b1-1085-1af1-1fd0d2265981@gmail.com>
 <a3ba73e5-ffd1-887e-acd9-11f537db27e0@acm.org>
 <b33a5330-472b-9961-c590-5c07420cf9de@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <70ed90fc-9de0-efcf-b591-8f1accc7dda6@acm.org>
Date:   Wed, 28 Jul 2021 10:55:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <b33a5330-472b-9961-c590-5c07420cf9de@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/21 10:14 AM, Bodo Stroesser wrote:
> I reviewed and tested the new patch. For me it works fine.
> 
> Just one warning to fix:
> 
> fs/configfs/file.c: In function ‘fill_write_buffer’:
> fs/configfs/file.c:184:6: warning: unused variable ‘to_copy’ [-Wunused-variable]
>    int to_copy, copied;
>        ^~~~~~~
> 
> Apart from that you can add my tested-by or reviewed-by if you want.

I will remove the 'to_copy' variable and also add your Tested-by. Thanks for
having tested this patch!

Bart.
