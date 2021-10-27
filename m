Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B72043D29D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 22:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbhJ0UPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 16:15:23 -0400
Received: from netrider.rowland.org ([192.131.102.5]:53763 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S240860AbhJ0UPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 16:15:17 -0400
Received: (qmail 1331338 invoked by uid 1000); 27 Oct 2021 16:12:49 -0400
Date:   Wed, 27 Oct 2021 16:12:49 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kernel development list <linux-kernel@vger.kernel.org>
Subject: GCC not detecting use of uninitialized variable?
Message-ID: <20211027201249.GA1326060@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following code does not generate a warning when compiled with GCC 
11.2.1:


int foo;

void cc_test(void)
{
	int	a, b;

	a = 0;
	a = READ_ONCE(foo);	// Should be: b = READ_ONCE(foo)
	do {
		a += b;
		b = READ_ONCE(foo);
	} while (a > 0);
	WRITE_ONCE(foo, a);
}


But if the loop is changed to execute only once -- replace the while 
test with "while (0)" -- then gcc does warn about the uninitialized use 
of b.

Is this a known problem with gcc?  Is it being too conservative about 
detecting uses of uninitialized variables?

Alan Stern
