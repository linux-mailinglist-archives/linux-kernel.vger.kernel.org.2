Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADC135B1CE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 07:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhDKE6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 00:58:55 -0400
Received: from smtprelay0002.hostedemail.com ([216.40.44.2]:40202 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229452AbhDKE6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 00:58:55 -0400
Received: from omf13.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 7876E181D3028;
        Sun, 11 Apr 2021 04:58:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 74CAB1124F5;
        Sun, 11 Apr 2021 04:58:37 +0000 (UTC)
Message-ID: <02ba29b5f196390a57f2d8b20dcf9a989fbaf2ed.camel@perches.com>
Subject: Re: drivers/parport/parport_cs.c:147 parport_config() warn:
 inconsistent indenting
From:   Joe Perches <joe@perches.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sat, 10 Apr 2021 21:58:36 -0700
In-Reply-To: <202104110202.486vI6NC-lkp@intel.com>
References: <202104110202.486vI6NC-lkp@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.60
X-Rspamd-Server: rspamout02
X-Stat-Signature: cxix5njjbczxbyi6rgyznkhhxcf5qcat
X-Rspamd-Queue-Id: 74CAB1124F5
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/agdpui/IVnB5oA71XbfWa8Y2v9x+rc2c=
X-HE-Tag: 1618117117-401762
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-04-11 at 02:02 +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d4961772226de3b48a395a26c076d450d7044c76
> commit: decf26f6ec25dac868782dc1751623a87d147831 parport: Convert printk(KERN_<LEVEL> to pr_<level>(
> date:   12 months ago
> config: x86_64-randconfig-m001-20210410 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> smatch warnings:
> drivers/parport/parport_cs.c:147 parport_config() warn: inconsistent indenting

False positive.
The whole thing is inconsistently indented. 


