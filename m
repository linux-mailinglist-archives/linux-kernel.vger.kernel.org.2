Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF060382A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbhEQK5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236556AbhEQK5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:57:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EDA9611C2;
        Mon, 17 May 2021 10:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621248948;
        bh=Jmz52vS0rUhcuE8XZGcoYPSLpUZeHpfX+XEx4c1umfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MFwRvqE4AV5vBOiV7YwGg3KZpfFQ+cyupSyCS8fBDToDJO3+OKl6VriCA9Nfy2R2I
         ORe/Bu5lx3wHZlN6hxVGPyVd9tbyhzc108uqqvZjAKw2v3fxfEYeXcvkixATorNXWf
         l7o/K31OdlqYgBGJGmmfa2iPDq8v5TH8t4LgqoovNm5bl99/KzIof8uqKMxcOGMuNF
         5gTaWFgRiVQgdG/ahVLq9hYoacpvSlvo1DnXhjJfyHuJWTfORYcOGYP9cEKgMZi4J8
         +hwn1EsJQA7iFQpf2dV7ahjIwJGp4IgkkIHLiY1oMaGhxcoKijIrly49mky/vBXYeS
         XY97jTDE8lX/w==
Date:   Mon, 17 May 2021 12:55:45 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] torture: Add --configonly parameter for kvm.sh
Message-ID: <20210517105545.GB199206@lothringen>
References: <20210506131510.51488-1-frederic@kernel.org>
 <20210506131510.51488-3-frederic@kernel.org>
 <20210507202910.GZ975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507202910.GZ975577@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 01:29:10PM -0700, Paul E. McKenney wrote:
> On Thu, May 06, 2021 at 03:15:09PM +0200, Frederic Weisbecker wrote:
> > Those who just want the resulting config file to generate for bare metal
> > don't need to wait for the build. Provide an option to only produce
> > the .config file.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> This one looks good to me, though it depends on 1/3.
> 
> I considered asking for a check of both --configonly and --buildonly,
> but on second thought I just couldn't see the point.  After all, it
> does say why it stopped, either "Config-only run" or "Build-only run"
> and that should suffice.

Ok, I'll resend this one as standalone then so we can think more clearly
on the rest.

Thanks!
