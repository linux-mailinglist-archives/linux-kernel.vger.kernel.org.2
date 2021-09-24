Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53585416A53
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 05:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbhIXDNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 23:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhIXDNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 23:13:45 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F0FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 20:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8aw5Hns9U4pY8NxnNOKcVnChXR35tjW0CCMnBx+eiiA=; b=0P6WvlXf1SbIKUouFJXEBB0tJk
        CP6zA73BJg4ZLlpgs9z4Qg8xlkp5Hsr/66u6QzLRChnbjSdCQo63P2AV3xE44DQ07Qdb716Yn+1rT
        UG5J6giTJRwgjXZW+dOWF7f4vhHqo5iO3OeXJ+LfQrHYgCBQe84EPT3VpiXfZp4nOLleb6pzXdG/o
        jnLKCaUlH63x/nW7Q4na6n8vdx+pGXDlX4xOd0HVYLQnCVGC/VeRnTcEz63YtZXfWbIBMpbTlSFYg
        hh810nnJF5YEfGIWReW7O1Ax1GVV/SemiXZkVgf6dJyMJp6V9JqsZOGhArJGW64QwPKu77lo7TSzL
        995T1rAg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTbdE-00Cy4v-Js; Fri, 24 Sep 2021 03:12:12 +0000
Date:   Thu, 23 Sep 2021 20:12:12 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     jeyu@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: fix invalid ELF structure error to print error
 code
Message-ID: <YU1CDIFm9nD0eBrx@bombadil.infradead.org>
References: <20210923001442.58278-1-skhan@linuxfoundation.org>
 <YUvtfUHb+8XjEtTf@bombadil.infradead.org>
 <93ef1a42-95e8-a8ec-a551-687fbd73570f@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93ef1a42-95e8-a8ec-a551-687fbd73570f@linuxfoundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 04:37:00PM -0600, Shuah Khan wrote:
> That is correct. This code path returns error without any indication
> of what happened and needs fixing. I can do that.

Great thanks!

  Luis
