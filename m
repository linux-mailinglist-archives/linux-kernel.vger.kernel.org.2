Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AC93466C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhCWRuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhCWRtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:49:55 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A4FC061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:49:55 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id j3so24416843edp.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RTCh+EZo7qjVQ20U6rRdw9u9Z+9l7eaBj85Pos8rwx4=;
        b=YSMqG32cbIHQ8jrFEam1sB3b8ZGrVqMu6SIb2djC4/YL4gITtSACGuScppgqvjTMk2
         tLVyTkT9BNM55K6/HyVLuFQRjIyqxQUyusVW90hOo2+l5xVbNTeFzntMQ6YAnix+AkML
         TDbrNO+gvaL+F8tPIyab83H46ReUTAKEMy26nCuG2ZDc16jPVplBTmj7u2tvepN07bWM
         tEfmw0Zq/zMh22TzoI4XMe0AKfnMnmmK6J0eD3Iqzoculez82O+SIjohBN7pP64Gi4Ur
         16dzDeg1xtd2F1et8u+CI8Tvz6dgLoW6E9YFGAaxsol4UVkRsf5mOsovoP7sPisVVW7t
         +MxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RTCh+EZo7qjVQ20U6rRdw9u9Z+9l7eaBj85Pos8rwx4=;
        b=WXjORjuzrUtInlldxkPl39BCc1hOpXLqYS4J8E/j+7bMyn5ye9lwqHA5FYSZF2xVtW
         1rEzalTpemd0kJRBkMQjXJMzlgcj8uFigfCUvhgKlCk6YnEgAYGz2PsLo4o6k9njOLuB
         57oTUofsHVSrk1G5id16YsModpbmd7Kx+DDx3936IFv6gvpin8dUirFPxoVMjLoG76/r
         aQvJV9ZAddQ2m6Dw+iitE3jNhXVFlNbxCpH3scY++mqamAzDXDq9FynIxnRWOhDOViOm
         j+gzgP94d18Ctgjs7y2+84N+vDGqa/p2VfRqdzBLzPJlSWab7uhWPAY/dqhD0i7BJE7z
         yOHg==
X-Gm-Message-State: AOAM531Q/yA9SAiCjHHbDW88y3YA66B4AsBNzmAPFRt1XzsbnlsdFNYc
        NXlaeAL63DtHg/KcBWPHFXQ=
X-Google-Smtp-Source: ABdhPJydQX+3YLlS2+89qNhdiV7/j5O505cyFcqlb6Zg9pgklYIsy8qSUllNqzIdkZVq7G8tZKtZZQ==
X-Received: by 2002:a05:6402:17d6:: with SMTP id s22mr5684544edy.232.1616521794024;
        Tue, 23 Mar 2021 10:49:54 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id r17sm11660710ejz.109.2021.03.23.10.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 10:49:53 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 23 Mar 2021 18:49:51 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, -v2] tracing: Fix various typos in comments
Message-ID: <20210323174951.GB4176821@gmail.com>
References: <20210322224546.GA1981273@gmail.com>
 <5e563a58-2ed6-3a1a-d92d-231fb6eecfa9@infradead.org>
 <20210323111150.GA3939639@gmail.com>
 <20210323085424.78dd3d78@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323085424.78dd3d78@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 23 Mar 2021 12:11:50 +0100
> Ingo Molnar <mingo@kernel.org> wrote:
> 
> > -v2 attached - I preemptively added your Reviewed-by as well, if 
> > that's fine. :-)
> > 
> > Thanks,
> > 
> > 	Ingo
> > 
> > =====================>  
> > From: Ingo Molnar <mingo@kernel.org>
> > Date: Mon, 22 Mar 2021 23:45:46 +0100
> > Subject: [PATCH] tracing: Fix various typos in comments
> 
> Hi Ingo,
> 
> Can you send this again as a separate patch in its own thread?
> 
> I use an internal patchwork on my inbox, and it wont pick up patches sent
> embedded in an email, and it doesn't always pick up patches that are in
> threads of other patches.

Sure, done.

Thanks,

	Ingo
