Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B693CCD38
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 07:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhGSFDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 01:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhGSFDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 01:03:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C0BC061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 22:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=fyy2cFtSOR6myZsJirx2R7GzmFZg7CatlnKUm7dPWT8=; b=Bm5SLGi5yCD9JyONTZfe4jxWfz
        oBKeEQKd5fVfZ9Z6G12IfrZ19uR1lCbc8ilgBXBa/ZX8Bo+WBw2R2LtP8vZrRcgH7FgXUekBkXu6C
        LcIUjRepZnwOkqggq12BPK6CqrWibTKHb7Z3DI7WJWf/aANlE6wjbWoIQ55Ux6xDE0iH4UxMeGXNo
        FvEqZN9RjnvHjI8gCtH7SSQ5xP6hP1qiU1UuT4cFbE1dSznweLy0Nfe8/eOtYbEbmqPIoNjHeKvRg
        coS7uLX0c+SMUP4nSbb4azOvj0adr8OIr8ehRBFC6BmRhowB2jvJxYos1zCt+mrN8zSgP9dQVbmZ0
        1lbajkfw==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5LOW-008Pne-L0; Mon, 19 Jul 2021 05:00:44 +0000
Subject: Re: [PATCH] openrisc: rename or32 code & comments to or1k
To:     Stafford Horne <shorne@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
References: <20210716022338.19342-1-rdunlap@infradead.org>
 <YPUCB7dSCHWrYHBl@antec>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <96469a3e-82b5-f2b1-c0ea-5975e85332ce@infradead.org>
Date:   Sun, 18 Jul 2021 22:00:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPUCB7dSCHWrYHBl@antec>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/21 9:39 PM, Stafford Horne wrote:
> On Thu, Jul 15, 2021 at 07:23:38PM -0700, Randy Dunlap wrote:
>> From Documentation/openrisc/todo.rst, rename "or32" in the
>> source code to "or1k" since this is the name that has been
>> settled on.
> 
> Hello, the kernel test robot found a build failure with this.
> 
> Will you send the update for that?
> 

Hi,

The robot problems are not related to this patch (they were
there before this patch), but I will send an update if you insist.

-- 
~Randy

