Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1B83F5EBD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbhHXNLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236443AbhHXNLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:11:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54088601FA;
        Tue, 24 Aug 2021 13:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629810657;
        bh=PW6cvHGXDI85qCdeSHXZV0s27uLi+w9M9L2zy/Bj2Bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yNHadYgswhOaBiBqo9aKstlpbvcBndhSkAUOuO9NwUI7qCvarfVlNPm+jUKVmLD/Q
         ezNbauTWltl6oHNLmV2RGfA8FCS00tu8RBxdVAMGyaKDOc51oCXis2IQQHzc5cvPEW
         JtClqd8NUj1B+FIyOYDCYcjudAPN2/LXTX1gzy+c=
Date:   Tue, 24 Aug 2021 15:10:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Julian Wiedmann <jwi@linux.ibm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: clean up open-coded NUMA_NO_NODE in
 device_initialize()
Message-ID: <YSTv3IrlpDM8QFFK@kroah.com>
References: <20210824103056.1571475-1-jwi@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824103056.1571475-1-jwi@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 12:30:55PM +0200, Julian Wiedmann wrote:
> Use the right macro to get rid of a magic number.

That is a very vague changelog comment.  You can do better :)

thanks,

greg k-h
