Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7D8338641
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 07:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhCLGys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 01:54:48 -0500
Received: from verein.lst.de ([213.95.11.211]:43952 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229866AbhCLGyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 01:54:16 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6928C68B05; Fri, 12 Mar 2021 07:54:13 +0100 (CET)
Date:   Fri, 12 Mar 2021 07:54:13 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: kmap_local semantics
Message-ID: <20210312065413.GA29805@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So with the new kmap_local interface is it possible / advisable to
use local kmaps over code that might schedule(), e.g. to wait for I/O?
