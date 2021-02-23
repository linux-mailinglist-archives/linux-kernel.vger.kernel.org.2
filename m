Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3F03234B4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 01:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhBXAtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 19:49:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:57290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234652AbhBXAEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 19:04:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8939B64EC3;
        Tue, 23 Feb 2021 23:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614124746;
        bh=jd3AHbAwpBRRufGrU+vgpTbPZS/a3wHGQ7fEjIZmmO0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J8gXSgvocsbDOdNuw2uM/tZVsiBnjNhvfF6J9y5QDoWBYSR9ANJRaWOuau92QJ4IH
         JDvz9mABEnSiDCPTBlX5g+rnonB3Pl8h/O6++VqjP/vatfuYBOdLJglqCebnbFvvm4
         GVyizs6325/7QuASONKyBfr7KHNl46CDUl+MGGgM=
Date:   Tue, 23 Feb 2021 15:59:05 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>, linux-kernel@vger.kernel.org,
        Kieran Bingham <kbingham@kernel.org>
Subject: Re: [PATCH v2] gdb: lx-symbols: store the abspath()
Message-Id: <20210223155905.ef395fd41affb2a49daf9bbd@linux-foundation.org>
In-Reply-To: <21aa1d80eccede559bebf7201f03a74e67272b4f.camel@sipsolutions.net>
References: <20201217091747.bf4332cf2b35.I10ebbdb7e9b80ab1a5cddebf53d073be8232d656@changeid>
        <60d43738-1d89-30b0-54bd-8303daeadc57@siemens.com>
        <21aa1d80eccede559bebf7201f03a74e67272b4f.camel@sipsolutions.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 16:12:17 +0100 Johannes Berg <johannes@sipsolutions.net> wrote:

> On Thu, 2020-12-17 at 09:31 +0100, Jan Kiszka wrote:
> > On 17.12.20 09:17, Johannes Berg wrote:
> > > From: Johannes Berg <johannes.berg@intel.com>
> > > 
> > > If we store the relative path, the user might later cd to a
> > > different directory, and that would break the automatic symbol
> > > resolving that happens when a module is loaded into the target
> > > kernel. Fix this by storing the abspath() of each path given,
> > > just like we already do for the cwd (os.getcwd() is absolute.)
> 
> > Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> So ... I'm still carrying this patch.
> 
> Anyone want to send it to Linus? Andrew, maybe you?

Sure, I'll grab it after -rc1.
