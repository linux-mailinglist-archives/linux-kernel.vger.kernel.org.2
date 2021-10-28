Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0EF43E5F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 18:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhJ1QWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 12:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhJ1QWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 12:22:42 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D19C061570;
        Thu, 28 Oct 2021 09:20:15 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id l24-20020a9d1c98000000b00552a5c6b23cso9294594ota.9;
        Thu, 28 Oct 2021 09:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qpc8jpsWVpJyk0cd0OJ7nlpLB5oumfHlBGc3n3seh8I=;
        b=RC6Wxlkoq2dVLklq2Jk0LTN1s8376mQdC+nJuxnPTooIzwe/azssI5ZCo6oAhn9Mz9
         OLjq7/lFO+NU0yvCOSoxzkSuhOUYDeBZ018jLgsyDO8rKmVfT8Qh1spxipVAC0HIJhAm
         EFWknDA6C11qJLmSKc7JcdpR37UD1p9EoazsmzGGAuP7ad0oykv0aWd8b2+mPOPvX8Nv
         A0y55TNc7w6NWO86Jm0r44hAlHJ/2Smh1YCIbk/DQk33+3Or4x9rAd5MxH8PHaKx4CzU
         +tR/Txani8LyXkcWIWsOdRy6VzxoJr5pXBznTP771dpn+dFttGy6IgVb2SPBF42hl8su
         0UXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qpc8jpsWVpJyk0cd0OJ7nlpLB5oumfHlBGc3n3seh8I=;
        b=X5lo3zDoHhEq5JNrDVjqF9KTKFWCb7GQ+Ci8a5NTtfSeya0Dv2WYW6ztVb2KHkEDUo
         8LVQFH+xfDS3WiTzvgrrq1ZwzpolLzKUIDKJk5N2CUwkjadrQcB33x1xIvItohWHTTGm
         k28+sd/7pXMo8VPzreGcz3fx/RqcBwYit3hgr7MRKcWGwEAojZOpExfXnEf973g2y/7m
         9SpiKLnnzjbfXn8ZnMuWU/cJq91hrkXFHUUR2X8CzQH6/+gFfFboyHQznz+n/e5Pvz5o
         XGr9G35TGR52jhgednlxS18a9hZDNUz80UjF/YS8SD7oWtwXs3D+TEgyOClXOi5/S9V9
         +LbA==
X-Gm-Message-State: AOAM5304xRrvKK1IsanUgoYQw8OPlvBOBOu/Ephs1xacZP/WAcEHJGM0
        SxmRtCTMTL/lPE3ylA14ZkO4CmQSkl0=
X-Google-Smtp-Source: ABdhPJzvi/sN32vb6BiJI0UOAyMHnmRji434S5M676KNZTpq8px/UHWPV6+07ie7eBpBdoujIFAHew==
X-Received: by 2002:a9d:669:: with SMTP id 96mr4176377otn.224.1635438015002;
        Thu, 28 Oct 2021 09:20:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p133sm1150001oia.11.2021.10.28.09.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 09:20:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 28 Oct 2021 09:20:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Wilson, David T. (GSFC-5870)" <david.wilson@nasa.gov>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: Potential issue with smb word operations for
 tmp461 device in tmp401 driver
Message-ID: <20211028162012.GA470146@roeck-us.net>
References: <SA1PR09MB7440BF952778F0DB8138747DE7B99@SA1PR09MB7440.namprd09.prod.outlook.com>
 <7f334e4c-0e71-2005-854f-c2d4e068ef85@roeck-us.net>
 <SA1PR09MB74408633E36AE3C97B4D2CA7E7BD9@SA1PR09MB7440.namprd09.prod.outlook.com>
 <3923f61f-031c-f293-dfbd-8db7efbce2cb@roeck-us.net>
 <SA1PR09MB7440DE6CE6882186ECDE3401E7BE9@SA1PR09MB7440.namprd09.prod.outlook.com>
 <8485a422-31b2-6d9f-516c-29d60fd13490@roeck-us.net>
 <SA1PR09MB74400C313FFCCEAE32A4C565E7869@SA1PR09MB7440.namprd09.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR09MB74400C313FFCCEAE32A4C565E7869@SA1PR09MB7440.namprd09.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thu, Oct 28, 2021 at 01:54:01AM +0000, Wilson, David T. (GSFC-5870) wrote:
> Hi Guenter,
> 
> Like last time, I updated several files in my platform's v5.4 files and applied your three patches. 
> From what I can tell, I'm having no problems with the tmp461's basic support in the modified lm90 driver.
> 
> Thanks again for looking into this,

I ordered an evaluation board from TI to be able to test improved support
for TMP461 in the lm90 driver (actual chips are all but impossible to get,
unless I am willing to wait for 9+ months). There are still some issues
with negative temperatures in standard mode and, as you noticed, with
resolution. I do have a board with TMP451 (which doesn't support negative
temperatures in standard mode), but that doesn't help with the TMP461
specifics. I'll keep you posted.

Guenter
