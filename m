Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B713A29B1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 12:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhFJLBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 07:01:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42924 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhFJLBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:01:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6C56621A24;
        Thu, 10 Jun 2021 10:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623322786;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zQS0qB/amfmlxFzlgfZBYMFK2FG3zor2og3viZ7XNGk=;
        b=V9d3nm8QpwImHkoYll84Z5KcYk5PQtB8GgO3vwN9tlx8/SVvNFInlgF5CLVQV/pdkuYTLb
        1MzKMVW55mPTy44s/sjIkClpEwnr5PPPaAhuSAaWQYbIu6K8lS9tqh4Q2q3AUjsWU1+bv5
        bODxcG4rqsbnSSmmvWboCISfW7tO+lw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623322786;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zQS0qB/amfmlxFzlgfZBYMFK2FG3zor2og3viZ7XNGk=;
        b=WZcfX5tRr/mGg0POBBSmg8vMRXepmz0ZgDwUdBubPFTOP/Hpl/qhoPTE+5FN8+mguIems/
        hwO6s/YE8c8weDDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5EE19A3B8A;
        Thu, 10 Jun 2021 10:59:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E0547DAEB9; Thu, 10 Jun 2021 12:57:01 +0200 (CEST)
Date:   Thu, 10 Jun 2021 12:57:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] ipwireless: remove unused ipw_tty::closing
Message-ID: <20210610105701.GA28158@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jiri Slaby <jslaby@suse.cz>,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>
References: <20210610090307.2689-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610090307.2689-1-jslaby@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 11:03:07AM +0200, Jiri Slaby wrote:
> It's only set, but never read.

Thanks. Please update the changelog with:

Commit 01261cb94318 ("tty: ipwireless: Remove tty->closing abort from
ipw_open()") removed last use of tty::closing.
