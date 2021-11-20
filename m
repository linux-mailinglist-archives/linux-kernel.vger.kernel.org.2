Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF53457F85
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 17:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhKTQg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 11:36:28 -0500
Received: from smtprelay0203.hostedemail.com ([216.40.44.203]:56204 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231390AbhKTQg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 11:36:28 -0500
Received: from omf13.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E6249180A3907;
        Sat, 20 Nov 2021 16:33:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 028FF2000508;
        Sat, 20 Nov 2021 16:33:14 +0000 (UTC)
Message-ID: <8d99e5cc64db64b6262b74aa7a9e04a642a7629f.camel@perches.com>
Subject: Re: [PATCH v2 11/20] linux/container_of.h: Cosmetic
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>
Date:   Sat, 20 Nov 2021 08:33:21 -0800
In-Reply-To: <CAHp75VfYvO2pHTtExLpcY1AmiGAEvvdf_Q_46ZhxR6JD68MNow@mail.gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
         <20211120130104.185699-1-alx.manpages@gmail.com>
         <20211120130104.185699-12-alx.manpages@gmail.com>
         <CAHp75VfYvO2pHTtExLpcY1AmiGAEvvdf_Q_46ZhxR6JD68MNow@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 028FF2000508
X-Spam-Status: No, score=-3.40
X-Stat-Signature: g6qzhpep5sgcgb56t8yb3addoi9xe36j
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+/Xhumv0711NBJQabUA30yEHojQITCsA8=
X-HE-Tag: 1637425994-837184
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-11-20 at 18:12 +0200, Andy Shevchenko wrote:
> On Sat, Nov 20, 2021 at 3:03 PM Alejandro Colomar
> <alx.manpages@gmail.com> wrote:
> > 
> > Place braces in a ({}) expression
> > similarly to how a function would have them.
> 
> I don't think we need this change. ({ on one line is pretty much
> idiomatic for macros.

true

$ grep-2.5.4 -rP --include=*.[ch] -oh '\(\s*\\?\s*\{' * | \
  sort | uniq -c | sort -rn
   2756 ({
     13 {
     13 ( {
      4 (			\
      2 ( \
      2 (                                \
      2 (		\
      1 (	\
      1 (				\
      1 (					\
      1 (									\
      1 		{


