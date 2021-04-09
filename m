Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE98359448
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhDIFFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231495AbhDIFFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:05:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D04F61165;
        Fri,  9 Apr 2021 05:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617944703;
        bh=EhKfhCtrh4/+sKA9h7krIX9UtMAkjmL2cH9TCGuvTs8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j9utn1dN+lZhBZ8xMluMnSqmnCo50rfK/pRfN3monDGCvkWWa8BToWdaYhK7iG8L4
         mdt/CZw38id9+fEms+32P2BKkA+S+uAMs2JNMk1SvtYbEwIBFPYle0UoNX3TnKAcIW
         ixHRjbo16n5X4a84MGR2horaw9gvMVWQc6Ecm6ww=
Date:   Thu, 8 Apr 2021 22:05:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        dan.j.williams@intel.com, laniel_francis@privacyrequired.com,
        keescook@chromium.org, dja@axtens.net, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4] lib/string: Introduce sysfs_streqcase
Message-Id: <20210408220502.8126bc2f278b5199707ec122@linux-foundation.org>
In-Reply-To: <20210408130605.541796-1-gi-oh.kim@ionos.com>
References: <20210408130605.541796-1-gi-oh.kim@ionos.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Apr 2021 15:06:05 +0200 Gioh Kim <gi-oh.kim@ionos.com> wrote:

> As the name shows, it checks if strings are equal in case insensitive
> manner.

Peh.  Who would die if we simply made sysfs_streq() case-insensitive?
