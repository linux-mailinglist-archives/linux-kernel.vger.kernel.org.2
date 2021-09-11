Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77500407A8B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 23:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhIKVi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 17:38:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:56841 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231472AbhIKViZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 17:38:25 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 18BLY2Jn030379;
        Sat, 11 Sep 2021 16:34:02 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 18BLY1Q0030378;
        Sat, 11 Sep 2021 16:34:01 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 11 Sep 2021 16:34:01 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, x86@kernel.org,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH] Makefile: 'Promote' -Wunused-but-set-variable to W=3
Message-ID: <20210911213401.GE1583@gate.crashing.org>
References: <20210911142905.GZ4323@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911142905.GZ4323@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 04:29:05PM +0200, Peter Zijlstra wrote:
> Upgrade -Wunused-but-set-variable to W=3 to avoid the build robots
> sending endless spam for this garbage warning.

"This warning for garbage code" you mean?

> By promoting it to W=3 the robots will no longer report it and people
> will no longer attempt to fix them by making the code worse.

Instead, they will not see such warnings, and make the code worse.


Segher
