Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2313A0C05
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 07:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhFIFys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 01:54:48 -0400
Received: from smtprelay0025.hostedemail.com ([216.40.44.25]:45708 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231354AbhFIFyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 01:54:45 -0400
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 64C4FAC14;
        Wed,  9 Jun 2021 05:52:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 2CDED315D76;
        Wed,  9 Jun 2021 05:52:49 +0000 (UTC)
Message-ID: <ece2404d0fa5e28b0d6c43014da476d722414e54.camel@perches.com>
Subject: Re: [PATCH 1/1] lib: remove leading spaces before tabs
From:   Joe Perches <joe@perches.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kenneth Albanowski <kenalba@google.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 08 Jun 2021 22:52:47 -0700
In-Reply-To: <26ee1009-259d-07a6-495f-87557be9ed8a@huawei.com>
References: <20210608071430.12687-1-thunder.leizhen@huawei.com>
         <CAHp75VfuMJ5kfRDB4tE2zr2Em79HiwrDJVROnw+kD3H+QNM4sg@mail.gmail.com>
         <da4915c5-fa13-0cf2-f2d2-02779a64af1b@huawei.com>
         <8a70d592e14f93822bf40832c7374d8e491c3afc.camel@perches.com>
         <26ee1009-259d-07a6-495f-87557be9ed8a@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.60
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 2CDED315D76
X-Stat-Signature: msfhb7gsn1aaqhsepcq65x1rodwkff4y
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/YytxuHsNdhlWkL5cE1r6JtdsW1cnMjSk=
X-HE-Tag: 1623217969-121136
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-06-09 at 13:15 +0800, Leizhen (ThunderTown) wrote:
> On 2021/6/9 0:03, Joe Perches wrote:

> >  lib/fonts/font_mini_4x6.c       | 512 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------
> 
> This file is horrible. It's hard not to correct it.

Except for some trivial bits, I think it's brilliant.
A lot of handwork went into that thing.


