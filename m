Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96183595B8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 08:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhDIGoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 02:44:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233335AbhDIGoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 02:44:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6FD8600D1;
        Fri,  9 Apr 2021 06:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617950682;
        bh=mLGbId4I3LWUC1UKeqj+M287Kn8T7tr04O180EJhuDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XB0SnJMEfvZInJzyzw0xey71WE7RN4TyLwETjJw2jKtziGbBRG2y1xZnyQwDCHMma
         ajo5CXe0P0OcNU6nHEiruuYC5Fv9XtfbFejPiaIXuct9nRqqo/TNW3G7ZHFRpP18dI
         TIq9mXRe+bPpXlicA1st3kAEWWCVi1mTcEyImah4=
Date:   Fri, 9 Apr 2021 08:44:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Gioh Kim <gi-oh.kim@ionos.com>, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, dan.j.williams@intel.com,
        laniel_francis@privacyrequired.com, keescook@chromium.org,
        dja@axtens.net, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: Re: [PATCH v4] lib/string: Introduce sysfs_streqcase
Message-ID: <YG/315XLSIZG2bCU@kroah.com>
References: <20210408130605.541796-1-gi-oh.kim@ionos.com>
 <20210408220502.8126bc2f278b5199707ec122@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408220502.8126bc2f278b5199707ec122@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 10:05:02PM -0700, Andrew Morton wrote:
> On Thu,  8 Apr 2021 15:06:05 +0200 Gioh Kim <gi-oh.kim@ionos.com> wrote:
> 
> > As the name shows, it checks if strings are equal in case insensitive
> > manner.
> 
> Peh.  Who would die if we simply made sysfs_streq() case-insensitive?

I doubt anyone, let's do that instead.
