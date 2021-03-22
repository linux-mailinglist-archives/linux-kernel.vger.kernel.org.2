Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36816344A79
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhCVQFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:05:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231848AbhCVQFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:05:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AD2B619AB;
        Mon, 22 Mar 2021 16:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616429107;
        bh=Ra9MAzqkKJlSO+yHzNSypAr67etWGptcqZyBCYt9Qmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bj41YKN3sG86Z5bQYMPMzDTGFWAbEjHH7ZzaflBuqXlsVc41ld6lpIszL+4NiYX82
         PJmKxCeEeR9QKMzzcGMjpPr3cjDHjWYH5z+634JZ0NkmSqMQgL9ZHfqvyl2xP+RO4M
         XnfnmLrhjf33HUYa9kKrK6HzegL/hLWm31WU1e8k=
Date:   Mon, 22 Mar 2021 17:05:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Mundane typo fixes
Message-ID: <YFjAMa6AJ0nOK7F3@kroah.com>
References: <20210322072808.996970-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322072808.996970-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 12:58:08PM +0530, Bhaskar Chowdhury wrote:
> 
> s/stoping/stooping/

Huh?

Are you _sure_ that is the correct replacement?  Last I looked it
wasn't...

greg k-h
