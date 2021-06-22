Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436ED3B08BC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhFVP0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:26:08 -0400
Received: from kanga.kvack.org ([205.233.56.17]:34451 "EHLO kanga.kvack.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232226AbhFVP0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:26:07 -0400
X-Greylist: delayed 1423 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jun 2021 11:26:07 EDT
Received: by kanga.kvack.org (Postfix, from userid 63042)
        id 073A86B0075; Tue, 22 Jun 2021 10:59:55 -0400 (EDT)
Date:   Tue, 22 Jun 2021 10:59:54 -0400
From:   Benjamin LaHaise <ben@communityfibre.ca>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: linux-mm@kvack.org - limping on a backup
Message-ID: <20210622145954.GA4058@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI: the filesystem hosting kanga.kvack.org which hosts linux-mm@kvack.org
and a few other assorted things was damaged around 9:17am.  The mailing
list is back up and running from a March 2nd backup for now.  The problem
is either a bad SSD or a btrfs bug, however no crash dump was captured to 
help with debugging.  New hardware will be deployed this afternoon after
an attempt at data recovery is made.

		-ben
-- 
"Thought is the essence of where you are now."
