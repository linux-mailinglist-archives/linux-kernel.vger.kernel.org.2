Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1588F31357E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 15:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhBHOqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 09:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbhBHOao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:30:44 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54815C061797
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 06:30:29 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id q2so18331708edi.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 06:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AMK8fsiLhk8GCcepxqG4I/t6njhgJTX5abL5a9RCMF8=;
        b=pK9uv1f8PgaLQLJcQU5uX+XSMBwpRZMNSPzKrn90KLg+BWXlZ6AgORJIjFKurMSr3t
         Nahe0DdgEuXbTwPNWeupd2Xbny/2jkuvdi0mDn1EO26s7gsvOkK8Y/auiZ2yyE3W+VEQ
         WRtJkw21jgEpH7eGd5uJZFpn4PXsKqSAEDrPEgTs2yk3vb+2Viu0WmgeFMwNuIckg4S3
         ZWgOt2HeN2ja9YXy9Esylh38iyOxZrqu1etpZ6NQ5qd1CWdT4vDSAd3LG6Du2upq9onU
         N+IwezBGE7nuEYBPwhjnfFDhG/5j5ucZF2ELkhY9d73eWfTfyeyB7FyeqQzRvW2VEwoh
         jPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AMK8fsiLhk8GCcepxqG4I/t6njhgJTX5abL5a9RCMF8=;
        b=fwyNIoglSh3RpaMzUBK8A72r67i2BXJeIynAKqBdkglQ1vzd818XYJCI8BApSwLBxa
         wSszVyQDiNmH3H/5yQnB+L24MLEakk0IIb9SdvUXQdIML70i5PL8wYCLQLPN4KXo8luX
         0th6IxA/aMtTmHR+p4yfGQ42eSnLt+cwlfvECqXYcxj7nFEntfFiCbXGgPb+SgkEIaFE
         OegZbImYa5EpjgXNP25BaG83F/J0QyJ0+PqR9lcuEkI0cfw2Mx8Vxqqd70AmVRu7pr46
         I1JBNDO10kCu/Ej+6u85miNUsu2+x+gCNGAYVMxZoIz6wXL9nD65RBXMhKXq4RpHOw8A
         fIJg==
X-Gm-Message-State: AOAM530O86u1vnqak02q3czHhFQ3HVqS75M54GfJYYEOfHfLiTIQWuhE
        ufEOih8SGaOsfk1SCfLsres22Rqn+g==
X-Google-Smtp-Source: ABdhPJywcZ2Wh6rigOxiLnw/l+ZIaKD2heWwtuxOVfYe+RyrfFsflDGri+6Sba2AbXlXaTLQLgp8Gw==
X-Received: by 2002:aa7:dc17:: with SMTP id b23mr17588682edu.139.1612794628161;
        Mon, 08 Feb 2021 06:30:28 -0800 (PST)
Received: from localhost.localdomain ([46.53.253.245])
        by smtp.gmail.com with ESMTPSA id u23sm9617804edt.87.2021.02.08.06.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 06:30:27 -0800 (PST)
Date:   Mon, 8 Feb 2021 17:30:25 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] sched: make struct task_struct::state 32-bit
Message-ID: <20210208143025.GA10066@localhost.localdomain>
References: <20210206151832.GA487103@localhost.localdomain>
 <YCETqt8Vqb8R6qmA@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCETqt8Vqb8R6qmA@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 11:34:18AM +0100, Peter Zijlstra wrote:
> On Sat, Feb 06, 2021 at 06:18:32PM +0300, Alexey Dobriyan wrote:
> 
> > Silently delete "extern" from prototypes.
> 
> NAK, extern is right.

Extern is only necessary for variables.
