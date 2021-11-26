Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D230F45F0D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 16:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378120AbhKZPkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378143AbhKZPip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:38:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67684C0613F2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 07:29:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 025E6B82811;
        Fri, 26 Nov 2021 15:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125A0C93056;
        Fri, 26 Nov 2021 15:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637940554;
        bh=xWAYeSXvSv88kJNEunVREZHHQoDhcTk0/UaJ3ba86Jg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zz2r/N6YG9o1YB6q4AGV7CZphcVMQqpwmkKtP+dt9WdWGeBJGlmKjhvZZIOPOoEC7
         KY0DSCnsuZLq7L4VjfoUwAotG9SazgxsuP+QhzmLU+iWSmNhTtWyUqRxe5wgKpC+t8
         MtfZyCqddEBiTc5WvKQISfXqGhZBpEpXWPI/MUuY=
Date:   Fri, 26 Nov 2021 16:28:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/23] tty: documentation revamp
Message-ID: <YaD9DVL10AZBLVS5@kroah.com>
References: <20211126081611.11001-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126081611.11001-1-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 09:15:48AM +0100, Jiri Slaby wrote:
> This series adds/updates:
> 1) kernel-doc documentation for most exported functions, and
> 2) adds a chapter to Documentation/tty to glue it all together.
> 
> I think it's a good base for further improvements. It deduplicates
> and unify multiple documentation files.

Wow, thanks for this!  All now queued up, much appreciated.

greg k-h
