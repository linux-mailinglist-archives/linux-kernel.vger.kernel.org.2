Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0798D42E135
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 20:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhJNS3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:29:18 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35996 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229690AbhJNS3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:29:17 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19EIR8qO000389
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 14:27:09 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A205C15C00CA; Thu, 14 Oct 2021 14:27:08 -0400 (EDT)
Date:   Thu, 14 Oct 2021 14:27:08 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     secret <andreas-stoewing@web.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: ???UNSURE??? Re: Unwanted activation of root-processes getting
 highly activated
Message-ID: <YWh2fO8/M82GxXZe@mit.edu>
References: <202110141240.12172.andreas-stoewing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110141240.12172.andreas-stoewing@web.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 12:40:08PM +0000, secret wrote:
> Hi,
> Firejail must have caused the high activity.
> Whenever I stop it (process firejail), they lower to origin.

This is what I had been trying to tell you repeatedly.  Firejail
(firefox run in a sandbox/jail) is a browser which will do various
activities on behalf of whatever web pages that you visit.  Some of
these webpages may have javascript, or other web-based application
code which is causing a lot of file I/O.  So when visiting that web
page causes firefox to execute a lot of file I/O, on behalf of the web
site, in order to service the file I/O, the kernel will do that work
in the kernel threads that you seem to be objecting to having
activity.

However, those kernel threads being active when there is file I/O is
*normal*.  It is the system working as intended.  I don't know why you
would be objecting to those kernel threads being active, but if you
don't like it, don't do any file I/O, and if that means not using
firefox (or "firejail") to visit those web sites.

Regards,

					- Ted
