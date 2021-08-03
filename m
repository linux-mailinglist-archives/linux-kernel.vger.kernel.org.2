Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EBE3DE486
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 04:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhHCCtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 22:49:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233436AbhHCCtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 22:49:19 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7CC960E09;
        Tue,  3 Aug 2021 02:49:07 +0000 (UTC)
Date:   Mon, 2 Aug 2021 22:49:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 01/17] libtracefs: Added new API tracefs_sql()
Message-ID: <20210802224900.20c2b419@oasis.local.home>
In-Reply-To: <CAM9d7cieXRLU3huWVSha-A=CvumEFq59QU_pXYDkeBNS3m_mRA@mail.gmail.com>
References: <20210730221824.595597-1-rostedt@goodmis.org>
        <20210730221824.595597-2-rostedt@goodmis.org>
        <CAM9d7cieXRLU3huWVSha-A=CvumEFq59QU_pXYDkeBNS3m_mRA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Aug 2021 16:45:39 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> > +%option caseless
> > +
> > +field          [a-z_][a-z0-9_\.]*
> > +qstring                \"[^\"]*\"
> > +hexnum         0x[0-9a-z]+
> > +number         [0-9a-z]+  
> 
> Do you mean a-f ?

Doh! Thanks, I'll fix that up for v2.

-- Steve
