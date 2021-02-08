Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FA0313DE2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbhBHSn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbhBHQpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:45:46 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C4EC061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 08:45:06 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id q2so19106692edi.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 08:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1lDzdrErHVic1wgVj90rBpN4+RPebZWSQvJBmMEuVb0=;
        b=myMFcu1sKys+C2nmMRr8rlN55YZSgynl+Ra65AIX2Pzs4L2mN30MBfBniZrC8L151B
         yToLpWekUpRkIIxYTOIjYJMn10I99v6iaQGuUb9zfh126akmDCewDS1rBJmYOzN1BIQv
         nVQwPb4tthkcFafH83h5pFsllYkNG/BiJG/UAuDFft0A/mtMzSdBcRIBexKNTKJ4xPmo
         BK3fAjr9q24FWP8DvavWKMurJeb+Ce6YNGsVtC0F8gWrEzjbhuN7e7leC/FbgPKc3L/V
         QSrzsUH9nL4KDorRI8u3173C0vKvrXlBJkt3jcxWbPjJu3ACWslpQOAII4bvRUG5NgIv
         GvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1lDzdrErHVic1wgVj90rBpN4+RPebZWSQvJBmMEuVb0=;
        b=AIMlAPUcIIWdx4W40+o3qAJvsYPDUiXdjuwj0Qc00fqt0FjaZR3B6t3Iu+nQqjheSu
         7C59onQdEfzNtU14sBPiBHMl5QbRb3UlnsHE77DTOKDcOHxj2/oPsyW9wmPNVNOi88rx
         H/cKSn8yVVC8FDS1gdRtDOuKO9f6Y8aNob0fsMTLwlxdwS4S91W3h/YqsvseH6Y7P+Vw
         sXf8RN1EZtDIQHGMtKQ/1NVY+7i+bgme+DOmF+dURVsrZCfde7oGTYshPv+SGi2PCDBx
         wf4mdEUHSPO6b1yySs6nMLthP1vIfSH71rX1CbH001HqzaEXaSI7tocCh0RjhofbP8Dz
         1xBQ==
X-Gm-Message-State: AOAM5314EBjMqg+FbYyhc/T0HYK+urnOPlIfS5qAMkk70tvDngNeVM15
        mY/5mG/xwvNKbxgAlQo7UA==
X-Google-Smtp-Source: ABdhPJzc7PxtB1S80jnNwciIvtczzpCeg0Zsz1YSn/W0Zx1Qh/lQXRgK35R6y9nCdWzNDGcFU+a7Vw==
X-Received: by 2002:aa7:d618:: with SMTP id c24mr3384708edr.7.1612802705294;
        Mon, 08 Feb 2021 08:45:05 -0800 (PST)
Received: from localhost.localdomain ([46.53.253.245])
        by smtp.gmail.com with ESMTPSA id o11sm9746214eds.19.2021.02.08.08.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 08:45:04 -0800 (PST)
Date:   Mon, 8 Feb 2021 19:45:03 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] sched: make struct task_struct::state 32-bit
Message-ID: <20210208164503.GA32698@localhost.localdomain>
References: <20210206151832.GA487103@localhost.localdomain>
 <YCETqt8Vqb8R6qmA@hirez.programming.kicks-ass.net>
 <20210208143025.GA10066@localhost.localdomain>
 <20210208145245.GA11701@localhost.localdomain>
 <YCFX7zuwp0haWZFl@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCFX7zuwp0haWZFl@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 04:25:35PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 08, 2021 at 05:52:45PM +0300, Alexey Dobriyan wrote:
> > On Mon, Feb 08, 2021 at 05:30:25PM +0300, Alexey Dobriyan wrote:
> > > On Mon, Feb 08, 2021 at 11:34:18AM +0100, Peter Zijlstra wrote:
> > > > On Sat, Feb 06, 2021 at 06:18:32PM +0300, Alexey Dobriyan wrote:
> > > > 
> > > > > Silently delete "extern" from prototypes.
> > > > 
> > > > NAK, extern is right.
> > > 
> > > Extern is only necessary for variables.
> > 
> > Specifically C17, 6.2.2 p5 (linkage of identifiers):
> > 
> > 	if the declaration of an identifier for a function has no
> > 	storage-class specifier, its linkage is determined exactly as if
> > 	it were declared with the storage-class specifier "extern".
> > 
> > This is why nothing happens if "extern" is deleted.
> 
> I know, but I still very much like extern on the function declarations
> too. It tells me the definition isn't to be found in this TU.

What can I say. The absense of function body should tell that.
