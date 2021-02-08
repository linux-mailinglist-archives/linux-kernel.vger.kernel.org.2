Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB103135C4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 15:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhBHOzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 09:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbhBHOxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:53:35 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051DAC061797
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 06:52:49 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id w1so25106709ejf.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 06:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MGSQQh7XcPLEfgtPB18NZzc+Dr/CR2C3PSnVCbtQq3U=;
        b=dmKAJz9v6XnfdsYdWp/Mr2MWdr3HbGpkHxPNPT2xuvOQ4oG6fhS5q1kRMJ6Qu6nC8a
         easeDqgPgje8NaGFm0GaaMmf7P+FiFDlliSdkGIGQN18Az/B4jfMl40mROcckVUXE/+i
         piX+e64GSdhQwDprx1ER1YMKyI2nT2nhTqsxu3+KaKViAiqaoFJY+Dn31e/3BHwUze2N
         kO7wB0UhHTqxaCH4Ze98gqH1pXJHYcKPQT/25o9I7ngw8wXG2O9XMfbkT+WJYhdOx1fe
         iB2ul5xoJwbVc0B6iFO9DQInFsTkDFxDhjxMJiRFZLnB/YrgTK/t1ozzO8aIU+zTSvut
         h5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MGSQQh7XcPLEfgtPB18NZzc+Dr/CR2C3PSnVCbtQq3U=;
        b=jofC8wf4V2LvYf6dnS+gr9bVPq+WSBcrtFs3tK7caMYYRettd60qXoidKzNcOe6KM4
         noIJ/0Fr+3YKPqNmst8aBeC/e/kFafjuRIBHLXO2fL72pejKxoOxp5NGCMbDdkNZ4zBI
         +ymIrWZyXjHYC9soVESV3S6jVk0HbPOZGnGrwGTJYU0pAsy0a9vKW5Id63sYgwiqBruE
         Fu8w4Y8xdik+Pk/+2Y42yOOzgQI/9OVvYnRcpUgtGc8qdlWOZCP4P3iAmIX/PfKpILl9
         A8D5739uG8wC0YDUMV8XN+lXfoxsXwwtz6Ic+yxnEG/dulUkTkC18G7H1BpJbFTdtPvW
         1AFQ==
X-Gm-Message-State: AOAM532KAB1ANQcCO4Uv2/8cOUFQr4d5QLJ7mr3uex6R2HGyZJGPuno2
        KqjN+yt6OhTkvKzCuecgZA==
X-Google-Smtp-Source: ABdhPJy23zX/kZKxhWRLyINmdVE393RZH+qNmhAmA+J9QnKFc3jVlmT6QNfrXn9nrOdU+WrpzbE6FQ==
X-Received: by 2002:a17:906:d0cd:: with SMTP id bq13mr17114727ejb.75.1612795967792;
        Mon, 08 Feb 2021 06:52:47 -0800 (PST)
Received: from localhost.localdomain ([46.53.253.245])
        by smtp.gmail.com with ESMTPSA id b25sm8086948ejz.100.2021.02.08.06.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 06:52:47 -0800 (PST)
Date:   Mon, 8 Feb 2021 17:52:45 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] sched: make struct task_struct::state 32-bit
Message-ID: <20210208145245.GA11701@localhost.localdomain>
References: <20210206151832.GA487103@localhost.localdomain>
 <YCETqt8Vqb8R6qmA@hirez.programming.kicks-ass.net>
 <20210208143025.GA10066@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210208143025.GA10066@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 05:30:25PM +0300, Alexey Dobriyan wrote:
> On Mon, Feb 08, 2021 at 11:34:18AM +0100, Peter Zijlstra wrote:
> > On Sat, Feb 06, 2021 at 06:18:32PM +0300, Alexey Dobriyan wrote:
> > 
> > > Silently delete "extern" from prototypes.
> > 
> > NAK, extern is right.
> 
> Extern is only necessary for variables.

Specifically C17, 6.2.2 p5 (linkage of identifiers):

	if the declaration of an identifier for a function has no
	storage-class specifier, its linkage is determined exactly as if
	it were declared with the storage-class specifier "extern".

This is why nothing happens if "extern" is deleted.
