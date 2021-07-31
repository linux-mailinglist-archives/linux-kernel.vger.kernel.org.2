Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315013DC646
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 16:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhGaOWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 10:22:11 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:58698 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbhGaOV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 10:21:59 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m9ppr-005VDZ-5V; Sat, 31 Jul 2021 14:19:31 +0000
Date:   Sat, 31 Jul 2021 14:19:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: use 'unsigned int' instead of bare 'unsigned'
Message-ID: <YQVb84k5eI4XqIwD@zeniv-ca.linux.org.uk>
References: <20210731125027.404300-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731125027.404300-1-wangborong@cdjrlc.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 08:50:27PM +0800, Jason Wang wrote:
> Prefer 'unsigned int' to bare use of 'unsigned'.

Why?  This is not much of an explanation, is it?
