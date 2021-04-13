Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A7B35DACE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245361AbhDMJM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245346AbhDMJMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:12:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F5EC061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 02:12:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id sd23so16098184ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 02:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cOAyiIpTL0MPS3HVlPhA17Z4KssVa29gOz8MIS/lLK4=;
        b=ReVQZ/tKm2GnT7ScEH9ClWtZBQDCG5i9KRPiqdu7rubKxmPXOyvG9goxkqig689jRp
         +6nnEPWj1qeORcIKvKahCIlDU52THgQVQNABsQnaKYAxNrJ8FDgZ6cQVlrfOUQ9O4n6W
         ZZX4OC0ZdpLgxs0x/Ru1TiWMafgZvU5+FeEBUxOOrK5XvHQCYcv+8k8ZlhtIFvhy4hPU
         TLWnNH1Nh7MTpj7UelhnYFV+/+2m+cuvgM/awVGc2xkPZYytcgHSD00w8P0MCfgdqg3D
         dJ+dPiqiZTPV0qbzU1V0VHTuM9DOkQSHN19amopX79h2JyMDpfWY8mtTqu4HODNK0Y0C
         w21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cOAyiIpTL0MPS3HVlPhA17Z4KssVa29gOz8MIS/lLK4=;
        b=XuaZGTUYK0KTQ33Kid6/QrMgL29LyvWeySkB2ESaeafnf41YrtG1s0eOTvSjLWRFft
         xF9dsx5GTERMjhmh46zdJf2LQaIYNOpzzA43DdjV+CcgWIznQXwEAl0HOf/oJe78sjT+
         /GQ9dIurcpM6zVfDLwyr7+sf+g/j32CHwJtgOoZ+ZydkDvZ5YQc5bi+teyQYI0zEjMbP
         W/aYy6XQXP+/LwNDBZ6BqCrjVJHNVZrQru1IUJQfarEtfod9QRclVUUUXqHb/PId19fa
         sesDHNv1mVk3eCUI4lUXbNfuP1CHGNL7fJuFDCO9DO5VHR8l9hSxxs1/A6Z6l1s4B6d5
         hQMA==
X-Gm-Message-State: AOAM532rq4Eng+R7IdZf5gmYiZoCD7AXyZvoNsDMbj28VJ3FqwaYLoC7
        LKwz0fkIbTa3RKHM8yUSjmw=
X-Google-Smtp-Source: ABdhPJxlaZO9nKzhGpRnRp0ThPh3RNrJ7SHbgJrXoc9b947qKLB6dXoR2hwOJ6NN1cDcBqtT8frAbg==
X-Received: by 2002:a17:907:33cb:: with SMTP id zk11mr14642441ejb.231.1618305144069;
        Tue, 13 Apr 2021 02:12:24 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id t11sm7389296ejs.95.2021.04.13.02.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 02:12:23 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: hal: Remove camelcase
Date:   Tue, 13 Apr 2021 11:12:22 +0200
Message-ID: <4613100.Flf31UX1ZZ@linux.local>
In-Reply-To: <YHVKwEX8CvV7brRg@kroah.com>
References: <20210412210258.8061-1-fmdefrancesco@gmail.com> <YHVKwEX8CvV7brRg@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 13, 2021 9:39:44 AM CEST Greg Kroah-Hartman wrote:
> On Mon, Apr 12, 2021 at 11:02:58PM +0200, Fabio M. De Francesco wrote:
> > Removed camelcase in (some) symbols. Further work is needed.
> 
> What symbols did you do this for?  What did you change them from and to?>
> 
> Be specific, and try to do only one structure at a time at the most,
> trying to review 1000 lines of changes at once is hard, would you want
> to do that?  :)
> 
For sure, if I were you, I wouldn't be reviewing one thousand lines of code 
at once :) 

OK, let's work on one item at a time  

I'd place each change in a patch of a series:

a) one global variable -> one patch with subject containing the name of the 
symbol (beware that if not 1000 lines you'll have to review 200 lines or 
more because that file is huge and its globals are used hundreds of times);
b) one or more local variables -> one single patch containing the name of 
the function where they are used;  

In the while, I'll remove also the trailing "p_" that stand for "pointer" 
(as Julia suggested). 

The above seems reasonable to me. Doesn't it?

Regarding what Matthew wrote about making use of  
drivers/net/wireless/realtek/rtlwifi/btcoexist/ I cannot work on it (too 
much time commitment would be needed, I suppose), but,  if someone else 
can, I won't do the above-mentioned tasks because they would be useless.

Said that, I'm not sure if removing camelcase in this file should be done 
at all.

Thanks,

Fabio
>
> thanks,
> 
> greg k-h




