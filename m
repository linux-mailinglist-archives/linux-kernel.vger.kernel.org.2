Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB0B3A2B07
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 14:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFJMHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 08:07:39 -0400
Received: from smtprelay0164.hostedemail.com ([216.40.44.164]:60338 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230301AbhFJMHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 08:07:38 -0400
Received: from omf03.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id D785D837F24D;
        Thu, 10 Jun 2021 12:05:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id D2E5B13D97;
        Thu, 10 Jun 2021 12:05:40 +0000 (UTC)
Message-ID: <c8671b993095e58ca8f3f82cc69e2651666331c6.camel@perches.com>
Subject: Re: [PATCH 1/1] lib: remove leading spaces before tabs
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Andy Shevchenko <andy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 10 Jun 2021 05:05:39 -0700
In-Reply-To: <YMHW80wUyFpW6Utf@smile.fi.intel.com>
References: <20210608071430.12687-1-thunder.leizhen@huawei.com>
         <CAHp75VfuMJ5kfRDB4tE2zr2Em79HiwrDJVROnw+kD3H+QNM4sg@mail.gmail.com>
         <da4915c5-fa13-0cf2-f2d2-02779a64af1b@huawei.com>
         <8a70d592e14f93822bf40832c7374d8e491c3afc.camel@perches.com>
         <26ee1009-259d-07a6-495f-87557be9ed8a@huawei.com>
         <3211e76c-d2a0-1e26-940b-9710073ee7d4@huawei.com>
         <CAHp75VfQq=RkjyZQsc-PHLTLRCzXovm-D_Z+Pp3A6vWGA-GKug@mail.gmail.com>
         <7e0f67a63b7093f4d20e0c0ccb076d9244e26a9a.camel@perches.com>
         <YMHW80wUyFpW6Utf@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.60
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: D2E5B13D97
X-Stat-Signature: z3xsqei7c8kq88nousuibsybqqmswc4z
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+d4z/nAXJADwvBfwOEcNkpZUKMByUC0cc=
X-HE-Tag: 1623326740-28987
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-06-10 at 12:10 +0300, Andy Shevchenko wrote:
> If you care about parallelism, the checkpatch should be doing it itself.

ridiculous argument.  g'night...



