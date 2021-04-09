Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B684359E46
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbhDIMGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:06:02 -0400
Received: from gate.crashing.org ([63.228.1.57]:45655 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231402AbhDIMGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:06:00 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 139C2LKn009728;
        Fri, 9 Apr 2021 07:02:21 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 139C2KHA009727;
        Fri, 9 Apr 2021 07:02:20 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 9 Apr 2021 07:02:20 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Yu Kuai <yukuai3@huawei.com>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH 2/2] powerpc: make 'boot_text_mapped' static
Message-ID: <20210409120220.GE26583@gate.crashing.org>
References: <20210408011801.557004-1-yukuai3@huawei.com> <20210408011801.557004-3-yukuai3@huawei.com> <5b91cd3f-d171-f510-7dae-8cbabb13b23c@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b91cd3f-d171-f510-7dae-8cbabb13b23c@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Apr 08, 2021 at 07:04:35AM +0200, Christophe Leroy wrote:
> Le 08/04/2021 à 03:18, Yu Kuai a écrit :
> >-int boot_text_mapped __force_data = 0;
> >+static int boot_text_mapped __force_data;
> 
> Are you sure the initialisation to 0 can be removed ? Usually 
> initialisation to 0 is not needed because not initialised variables go in 
> the BSS section which is zeroed at startup. But here the variable is 
> flagged with __force_data so it is not going in the BSS section.

Any non-automatic (i.e. function-scope, not static) variable is
initialised to 0.  See e.g. C11 6.7.9/10 (this has been like that since
times immemorial, C90 anyway).


Segher
