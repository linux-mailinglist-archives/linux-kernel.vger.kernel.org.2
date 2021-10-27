Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023BB43CAC1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 15:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242186AbhJ0NhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 09:37:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33082 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbhJ0NhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 09:37:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 21415218DF;
        Wed, 27 Oct 2021 13:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635341677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q5+utnyF8HjbUeR4UkohJcsYhnPljj2O4nNDOLy/nqQ=;
        b=rcdFrYUU3p+9it76IoAQeaLcs+1yQ06SAHfTpTkU5XKjtgGqfC8H5AvhNXonaeJSjW443k
        1pkS6Pto4UZCHppzEKZ5lbZNEzsrUOvuTajeYWp9f9zUCSw9WU1lZ6948tR+UBaFWfDMrH
        ZSOe0P+7H9T6p0BOZSnFLM3wwrM+6cY=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CFEB4A3B8C;
        Wed, 27 Oct 2021 13:34:36 +0000 (UTC)
Date:   Wed, 27 Oct 2021 15:34:36 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/1] lib/vsprintf.c: Amend static asserts for format
 specifier flags
Message-ID: <YXlVbPzK4OqktSf6@alley>
References: <20211026140356.45610-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026140356.45610-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-10-26 17:03:56, Andy Shevchenko wrote:
> There are couple of improvements to static asserts against
> the format specifier flags:
> 
> - new static assert for SIGN
> - fix static assert for SMALL
> 
> SMALL is not equal to ASCII code of white space, it equals to
> the bit difference between capital and small letters (however
> the value is the same, semantically expression means different
> things).
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The patch has been committed into printk/linux.git, branch for-5.16.

Best Regards,
Petr
