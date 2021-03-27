Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B5734B64D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 11:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhC0Kml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 06:42:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229875AbhC0Kml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 06:42:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3867361993;
        Sat, 27 Mar 2021 10:42:40 +0000 (UTC)
Date:   Sat, 27 Mar 2021 11:42:37 +0100
From:   Greg KH <greg@kroah.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/9] debugfs: Implement debugfs_create_str()
Message-ID: <YF8MHXcEfSbN1xBd@kroah.com>
References: <20210326103352.603456266@infradead.org>
 <20210326103935.183934395@infradead.org>
 <20210326145000.GK4746@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326145000.GK4746@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 03:50:00PM +0100, Peter Zijlstra wrote:
> Subject: debugfs: Implement debugfs_create_str()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu Mar 25 10:53:55 CET 2021
> 
> Implement debugfs_create_str() to easily display names and such in
> debugfs.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
