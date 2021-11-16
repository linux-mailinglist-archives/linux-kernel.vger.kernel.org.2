Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FABF453BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 22:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhKPVoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 16:44:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:59456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229605AbhKPVoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 16:44:19 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF4ED61263;
        Tue, 16 Nov 2021 21:41:21 +0000 (UTC)
Date:   Tue, 16 Nov 2021 16:41:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: Add helper functions to simplify
 event_command callback handling
Message-ID: <20211116164120.0db8212b@gandalf.local.home>
In-Reply-To: <2b228845d7aa0466702ffc93db5f22bd6252c43b.1636748267.git.zanussi@kernel.org>
References: <cover.1636748267.git.zanussi@kernel.org>
        <2b228845d7aa0466702ffc93db5f22bd6252c43b.1636748267.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2021 14:23:39 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

>  
> +int event_trigger_check(char *glob, char **trigger, char **param,
> +			bool *remove, bool require_param, bool separate_trigger)

All these functions are going to require having kerneldoc comments for
them. I rather not have to try to figure out what these functions are for
and just read the documentation.

-- Steve


> +{
> +	int ret = 0;
> +
> +	*remove = (glob && glob[0] == '!') ? true : false;
> +
