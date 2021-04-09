Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E6B3595D6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 08:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbhDIGwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 02:52:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233333AbhDIGwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 02:52:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06AAB610FC;
        Fri,  9 Apr 2021 06:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617951093;
        bh=rpxdJ+VoQo4exBN4jPf+RLIrO1vUqpKfUs6VC0gjRv8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d8hSSOgx1UTougP+ANtHxesbQOAwBtspUUXVyNAHSGCgx361cOHfHF+Hp6l5GSk5K
         8vPc5JDAneVT29XdrYpmGwCyZza4pdb+eKcrizHfBMK1Uv1Rp7nuNwFgizsyXhlA6T
         ydo/fTOE0h3ctovMUNK8ifP/uK6K+fA7ua07T604=
Date:   Thu, 8 Apr 2021 23:51:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Gioh Kim <gi-oh.kim@ionos.com>, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, dan.j.williams@intel.com,
        laniel_francis@privacyrequired.com, keescook@chromium.org,
        dja@axtens.net, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: Re: [PATCH v4] lib/string: Introduce sysfs_streqcase
Message-Id: <20210408235132.e62ace3277fd46f123f5ff1b@linux-foundation.org>
In-Reply-To: <YG/315XLSIZG2bCU@kroah.com>
References: <20210408130605.541796-1-gi-oh.kim@ionos.com>
        <20210408220502.8126bc2f278b5199707ec122@linux-foundation.org>
        <YG/315XLSIZG2bCU@kroah.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2021 08:44:39 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Apr 08, 2021 at 10:05:02PM -0700, Andrew Morton wrote:
> > On Thu,  8 Apr 2021 15:06:05 +0200 Gioh Kim <gi-oh.kim@ionos.com> wrote:
> > 
> > > As the name shows, it checks if strings are equal in case insensitive
> > > manner.
> > 
> > Peh.  Who would die if we simply made sysfs_streq() case-insensitive?
> 
> I doubt anyone, let's do that instead.

There's a risk that people will write scripts/config/etc on a 5.13+
kernel and then find that they malfunction on earlier kernels...

