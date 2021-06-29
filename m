Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C055F3B7903
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 22:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhF2UDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 16:03:38 -0400
Received: from smtprelay0162.hostedemail.com ([216.40.44.162]:54354 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232602AbhF2UDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 16:03:37 -0400
Received: from omf09.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id D451618204CEC;
        Tue, 29 Jun 2021 20:01:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 2BFE41E04DC;
        Tue, 29 Jun 2021 20:01:07 +0000 (UTC)
Message-ID: <cabb80f84ee0c11aaa548e8ebc87da72883c5a21.camel@perches.com>
Subject: Re: [PATCH 1/3] checkpatch: skip spacing tests on linker scripts
From:   Joe Perches <joe@perches.com>
To:     jim.cromie@gmail.com
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 29 Jun 2021 13:01:05 -0700
In-Reply-To: <CAJfuBxyQ8OX8+A64SQPG4pXYKBDhyab7_-Dcc_C2_t-4oG9xng@mail.gmail.com>
References: <20210626034016.170306-1-jim.cromie@gmail.com>
         <20210626034016.170306-2-jim.cromie@gmail.com>
         <075e07c40b99f93123051ef8833612bc88a55120.camel@perches.com>
         <CAJfuBxxzBevMJYSWq5feO20S4h_T-+EZoifOTYJ1NB4B+J1hqQ@mail.gmail.com>
         <CAJfuBxywc=oc00F7b=dJU9y_vgrncCUYzvLNgM5VaMsuOiDAyg@mail.gmail.com>
         <5d28704b131e375347f266b10fc54891ba2a4fc4.camel@perches.com>
         <CAJfuBxyQ8OX8+A64SQPG4pXYKBDhyab7_-Dcc_C2_t-4oG9xng@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.86
X-Stat-Signature: gt4p71cb7jctfptui1fcek6ewmszuy45
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 2BFE41E04DC
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+KX+c3jA4QjSnXZF+h2f0boxgJs1koLXo=
X-HE-Tag: 1624996867-582727
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-06-29 at 13:50 -0600, jim.cromie@gmail.com wrote:
> this does 3 different things
> 
> - non-capturing matches  -  these add no functionality,

true, it's nominally a bit faster through.

> - moves the skip-remaining-tests check after SPDX
>    that feels like a legal Q: should it be on all files ?
>    moving it does seem proper though.

to me too.

> - adds the skip linker-script
>   since i went ahead and added it 3 times to see errs/warns
>   I didnt consider your precise placement,
>   how does it do with 18/8 errs/warnings on ref-test ?

$ ./scripts/checkpatch.pl -f include/asm-generic/vmlinux.lds.h --strict --terse
include/asm-generic/vmlinux.lds.h:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
include/asm-generic/vmlinux.lds.h:43: WARNING: please, no space before tabs
include/asm-generic/vmlinux.lds.h:101: CHECK: line length of 106 exceeds 100 columns
include/asm-generic/vmlinux.lds.h:390: WARNING: please, no space before tabs
include/asm-generic/vmlinux.lds.h:546: ERROR: code indent should use tabs where possible
total: 1 errors, 3 warnings, 1 checks, 1184 lines checked


