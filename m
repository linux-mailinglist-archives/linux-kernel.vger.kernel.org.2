Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472B83A7E70
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFOM4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:56:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:53555 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230083AbhFOM4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:56:14 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 15FCowXA024371;
        Tue, 15 Jun 2021 07:50:58 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 15FCov2C024367;
        Tue, 15 Jun 2021 07:50:57 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 15 Jun 2021 07:50:57 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] module: add elf_check_module_arch for module specific elf arch checks
Message-ID: <20210615125057.GF5077@gate.crashing.org>
References: <20210611093959.821525-1-npiggin@gmail.com> <20210611093959.821525-2-npiggin@gmail.com> <YMdGWjBOmcstBwOl@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de> <1623722110.amu32mwaqs.astroid@bobo.none> <YMiaZOqhHck9iy0n@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMiaZOqhHck9iy0n@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 02:17:40PM +0200, Jessica Yu wrote:
> +int __weak elf_check_module_arch(Elf_Ehdr *hdr)
> +{
> +       return 1;
> +}

But is this a good idea?  It isn't useful to be able to attempt to load
a module not compiled for your architecture, and it increases the attack
surface tremendously.  These checks are one of the few things that can
*not* be weak symbols, imo.


Segher
