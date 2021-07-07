Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83813BEA8B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 17:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhGGPVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 11:21:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232050AbhGGPVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 11:21:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C72E561CC1;
        Wed,  7 Jul 2021 15:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625671138;
        bh=OBMw3GXF4Vb3gXXLiv+kzTAMUuODEO//MtnyB18PNc4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MUSigRRJvw14/mnyWUa9pfCMe/83mAM5ISzVn/YbIKJzK9v0/1H0wgCJbsJfHiAG6
         VJn1TRSJaTInKLLDC3TMBsLxUzQOLWBp5oa79uNRVlshzzo5cWUHAcVt14rrSenfoC
         cBJ5xR4On9dDuyPkvOYtE1/vn0k/8TOC9HctNGoEXMHEgaNVdRMc01quNj7JXHRhEC
         7nimwcjJXamQP7/QB3xw8G/PYzArxoCjEzNt5PLkCiptOBMzW3buUBwKTpm4xN1eKM
         R9aVYg0Yz+umg+dqRKMzLl93NKdTaTs8ZEKf6vSpScTyTWGt8mPzK3lXNEP5pUmQQV
         8HFXQrVVpiQNw==
Message-ID: <bd70fa726aa681e3a36840d54a81ec59d2cc78b5.camel@kernel.org>
Subject: Re: [PATCH v2] tracing: Add linear buckets to histogram logic
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Daniel Bristot de Oliveira Subject: [PATCH] tracing:" 
        <bristot@redhat.com>
Date:   Wed, 07 Jul 2021 10:18:56 -0500
In-Reply-To: <20210707111102.749d1fbc@oasis.local.home>
References: <20210706154315.3567166e@gandalf.local.home>
         <CAM9d7chmHmm3tjJik5EQDOJOdn7G0D3W9EJUogf_POnyTe6tcA@mail.gmail.com>
         <20210706205039.64182493@rorschach.local.home>
         <CAM9d7chF1Qnch5PmhfAWbTPcN5ocgVEvNKqFYsLxWOiaZPdYgQ@mail.gmail.com>
         <20210707111102.749d1fbc@oasis.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-07-07 at 11:11 -0400, Steven Rostedt wrote:
> On Wed, 7 Jul 2021 07:00:32 -0700
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > > I feel is farther from log2 than my version. Stating that "~"
> > > means
> > > approximation, what does "0 ~ 99" really mean?  
> > 
> > To me, it means "range".  The original intention was to
> > express [FROM, TO) and I thought we can omit the FROM
> > since it's same as TO of the previous line.  But we can use
> > inclusive ranges with FROM and TO for clarity.
> > 
> > But it's up to you.  I don't object to your change.
> 
> Thanks, I'd like to keep it as is. Unless Tom has any issues with it.
> 
> Tom?

Yeah, I prefer the explicit ranges too - it leaves nothing open to
interpretation.

Tom

> 
> -- Steve

