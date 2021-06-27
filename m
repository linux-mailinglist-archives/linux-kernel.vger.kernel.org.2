Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D79F3B5500
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 21:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhF0TWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 15:22:36 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:57208 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbhF0TWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 15:22:35 -0400
Received: from [192.168.0.2] (188-167-68-178.dynamic.chello.sk [188.167.68.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 9A4607A027B;
        Sun, 27 Jun 2021 21:20:09 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Marcos Del Sol Vives <marcos@orca.pet>
Subject: Re: [PATCH v3] x86: add NOPL and CMOV emulation
Date:   Sun, 27 Jun 2021 21:20:06 +0200
User-Agent: KMail/1.9.10
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
References: <YNWAwVfzSdML/WhO@hirez.programming.kicks-ass.net> <20210626130313.1283485-1-marcos@orca.pet>
In-Reply-To: <20210626130313.1283485-1-marcos@orca.pet>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202106272120.07140.linux@zary.sk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 June 2021 15:03:14 Marcos Del Sol Vives wrote:
> NOPL and CMOV are a set of instructions that were introduced to the
> x86 architecture with the i686 ISA in 1995, first implemented in the
> Intel Pentium Pro and Pentium II processors.
> 
> While virtually all desktop and server systems are modern enough to
> support these instructions, in the embedded market things are a little
> bit different: DM&P is still manufacturing their i586-only Vortex86
> SoCs, and many embedded devices still in use are stuck on legacy SoCs
> that either are i586-only (AMD Elan, AMD Geode GX1) or implement i686
> but lack the NOPL instructions (Transmeta devices, AMD Geode LX).
> 
> This is a problem because most modern Linux distributions, such as
> Debian and all its derivatives, have started compiling targeting i686,
> leaving old embedded devices using binary distributions without an
> easy upgrade path.
> 
> This ultimately results in most of these embedded devices running
> years old, insecure and obsolete installations, and this itself can be
> seen on the DM&P's own supported OS page where the newest supported
> desktop Linux distro is Ubuntu 18.04, already three years old.
> 
> The emulation of these instructions thus allow upgrading to newer
> distributions just by replacing the kernel, keeping all precompiled
> binaries intact.

Great, this would allow me to update my old Pentium 133 box from unsupported Debian 8 to 9, 10 and even the upcoming 11.

-- 
Ondrej Zary
