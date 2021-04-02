Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605AA352F71
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 20:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbhDBSt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 14:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBStW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 14:49:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53B3C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 11:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=5imDHSwUQgOQxNC3QbJlwJWAuCKtgprf+OXufQ8xKUI=; b=OWrtf2ShLsrxIdQboFPAmWoB9a
        wPpsYRyHqCVywTt3OWv819le9vEGjof/FZfZFZUHWMFlRhD2SbF5HwyYxf35FHWaPOhrfVRDNAi1a
        NcjF9/duz/jBGkRCtdnMNJXYS7bdqDrEbjEq1+d7O9mxjfFnAbuGuZ0z1+fdEJFYOb7Aa/nBl3ytp
        ZUikvVlKslGjVT2pfKJI7ZemI7PKJ4Ft0fsCacDyc3KCfpDqYGL5sdbOFLLNtrrh4QfMgYo9vwNKN
        56FES1+4Ne4S25k1Ek0hDoI6BvJtzlo9A0y4+JHojdHSQvj46ZDBtV4rR+m7lxnlAsJ6dMtnIgmKE
        Y/5J4p6Q==;
Received: from [2601:1c0:6280:3f0::e0e1]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lSOr3-00800S-CN; Fri, 02 Apr 2021 18:49:16 +0000
Subject: Re: Compiling Linux kernel into a build directory
To:     James Courtier-Dutton <james.dutton@gmail.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>
References: <CAAMvbhGzj3mTbNoLf55ZF5hdEFwRg5xj1J+g5jP-BW+Hn9kn=Q@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <acb6aef1-c8b2-1f0b-3859-be72aad3e0eb@infradead.org>
Date:   Fri, 2 Apr 2021 11:49:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAAMvbhGzj3mTbNoLf55ZF5hdEFwRg5xj1J+g5jP-BW+Hn9kn=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/21 11:29 AM, James Courtier-Dutton wrote:
> Hi,
> 
> Currently, when one builds the linux kernel, it places .o files all
> over the source code tree.
> Is there a way to have the linux kernel build, but place all the .o
> files into a separate build folder?
> Similar to how cmake or ninja work when building C source code.
> 
> One possible advantage of this approach is one can then put the build
> folder on a ram disk / tmpfs   and be able to compile and test much
> quicker.

That has been available for quite a long time now.
Just use "O=somebuilddir" on the make command line.

$ mkdir build
$ make O=build allnoconfig
$ make O=build all

AFAIK 'somebuilddir' can be a relative path (that's what
I use, in the kernel source tree) or an absolute path,
like O=/tmp/buildit .

From kernel Makefile "help":
	@echo  '  make O=dir [targets] Locate all output files in "dir", including .config'


and from kernel Makefile comments:

# Kbuild will save output files in the current working directory.
# This does not need to match to the root of the kernel source tree.
#
# For example, you can do this:
#
#  cd /dir/to/store/output/files; make -f /dir/to/kernel/source/Makefile
#
# If you want to save output files in a different location, there are
# two syntaxes to specify it.
#
# 1) O=
# Use "make O=dir/to/store/output/files/"
#
# 2) Set KBUILD_OUTPUT
# Set the environment variable KBUILD_OUTPUT to point to the output directory.
# export KBUILD_OUTPUT=dir/to/store/output/files/; make
#
# The O= assignment takes precedence over the KBUILD_OUTPUT environment
# variable.


HTH.
-- 
~Randy

