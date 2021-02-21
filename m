Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A1D320A89
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 14:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBUNXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 08:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhBUNXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 08:23:52 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64881C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 05:23:12 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id k13so4889541pfh.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 05:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DHV2IqAESmDmvK+skITBNU6iCUPe9/Bxc8okZh/sX10=;
        b=sZMagYH7p42jD47UvJ/SNJUYZygNeET71vZCajUmNEo5p6dXAmfrggMBhlXGWnx9SF
         aMpQDwaBjYxRJLwNtZd1kvdhjXKcM4HEyeE2EO7zM94NzjEOcFSGfLXWPChQeSVNu1GM
         jYv7UFREw/4ya0OfrXPJe0eQOV9vtSzFP30rydV0edkunEkvxGea0eWNcldS1ZT4JMnW
         OcQr/Ls0KIkQbXQQ3KaeohnpUDHx4EZoWMNF9Tto3KAtb45F/2b1DjTvf3pqizIa16SB
         G0smyoJzv+6u+S5AcNt8JGGDds5SdwVtkKhG4IFchvHygyCLhYRHCVhKN9Tr+pxjAVbO
         j4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DHV2IqAESmDmvK+skITBNU6iCUPe9/Bxc8okZh/sX10=;
        b=jMUHNdoyT5kpN7L6TI0NQfJ+5JumaDjA8vJ2lveO5W58+uwfDJV7ikih4nGhULG9wD
         Z9MxjLo4mCH/NszfotrLRUrLo7wGyLJDQ0rce49242p4zqRFVUxqtSEMIRZhPKW8sg/s
         px9+/n0Z7aORfkNtsnKQqReehf0+KuAD5AMZ+I8colnfs9mYt1wQVnwVYwstcWrbNYfW
         HI+WZjJNf+ZZMSFalDfBNxk2Kj94T63yZkDMcfn+qFIJbhp9WABCBZlaVq9jNPLY3vbk
         06tTjuR9ebDoJ5D9acT0++YqtjTdorVzccbfBaTRwqWJPCat5vXBQNZp5BLuzOAv/Zjr
         /mWA==
X-Gm-Message-State: AOAM530Dj7bkZEyhQaA6qQ7Mj4JPZYRMqs0KAYKArtD5evxpBryyL9P2
        psSCci/4tnKP2yUsiTekTcWiPzQDLihTdHA8nhM=
X-Google-Smtp-Source: ABdhPJzNjkdyRxo47eHtEpwfdVPu/g2m8LjWdkdz09hh12N5btTpSvWDhRfJdOIk/NoraTJ9xVCuhQ==
X-Received: by 2002:a62:e808:0:b029:1e5:f10a:e6d8 with SMTP id c8-20020a62e8080000b02901e5f10ae6d8mr17757411pfi.23.1613913791447;
        Sun, 21 Feb 2021 05:23:11 -0800 (PST)
Received: from ?IPv6:2409:4064:4e8b:6666:843b:eeba:783:b146? ([2409:4064:4e8b:6666:843b:eeba:783:b146])
        by smtp.gmail.com with ESMTPSA id c26sm17987124pfj.183.2021.02.21.05.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Feb 2021 05:23:11 -0800 (PST)
Subject: Re: [PATCH v2] staging: wimax: i2400m: add space before open
 parenthesis
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     sfr@canb.auug.org.au, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20210220104816.13263-1-sssraj.sssraj@gmail.com>
 <20210220134652.16127-1-sssraj.sssraj@gmail.com> <YDJaw5p/VM2qhULU@kroah.com>
From:   Rajesh Kumbhakar <sssraj.sssraj@gmail.com>
Message-ID: <a29fb121-2f22-fffa-630d-e99b380e4121@gmail.com>
Date:   Sun, 21 Feb 2021 18:53:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YDJaw5p/VM2qhULU@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21-02-2021 18:36, Greg KH wrote:
> On Sat, Feb 20, 2021 at 05:46:52AM -0800, Rajesh Kumbhakar wrote:
>> netdev.c
>>
>> fixing style ERROR: space required before the open parenthesis '('
>>
>> Signed-off-by: Rajesh Kumbhakar <sssraj.sssraj@gmail.com>
>> ---
>> Changes in v2:
>> 	- Removed filename from commit message.
> filename is still in commit message :(
aah, not again. please bare with me this last time, will surely never 
repeat this.
