Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4895344652E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 15:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhKEOqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 10:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhKEOqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 10:46:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC2CC061714;
        Fri,  5 Nov 2021 07:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PXmsu4hRmHvq6NlFme2974irRfGM8+ixHYT5BUYOG3s=; b=npl3lXte8fRasEmmPvw8X8v4WS
        3x21DcecXyFLXkhDGdaGxECVPzXRiTEavnK9epO5+i1zFTwXX0pNvr1yr6HZoiDYN9zvUkT4eilge
        nxS6r7f+E0HS7lFPJCgwyoZb2bHWP+DnV+7o9j8nhIwTy81op0qfqCpiY5hC4XIdvHCeoTCXlstc0
        NkGy5PECWqjvJ/DVd2DAmf+9VRAGkHBrR4DVsQZ7CXviVBNIp9nX0C1o57zSs3E4AQ3qBXyHbRGTY
        lAHM2OckdNwfPPWHSQK66LlSq5bqRt99dHaBtuCjwpm1p+St6Jhn23GWH7qRXPNb8okkv5MftRX5V
        urm/RTzg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj0Qa-006cJ9-6C; Fri, 05 Nov 2021 14:43:06 +0000
Date:   Fri, 5 Nov 2021 14:42:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 (RFC)] docs: discourage users from using
 bugzilla.kernel.org
Message-ID: <YYVC6Nd+XjG6shDV@casper.infradead.org>
References: <20210110121033.130504-1-linux@leemhuis.info>
 <6abc7248-efda-b569-9030-5384e5ce1f29@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6abc7248-efda-b569-9030-5384e5ce1f29@gmx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 02:36:51PM +0000, Artem S. Tashkinov wrote:
> Hello,
> 
> Let me express an utter dissatisfaction and even contempt for this proposal.

Thank you for volunteering to take over administration of
bugzilla.kernel.org.  Can you lay out your plans for making kernel
developers care about it?
