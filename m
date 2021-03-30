Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F8834EB14
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhC3Ovm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:51:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232118AbhC3Ovc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:51:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A07F60C41;
        Tue, 30 Mar 2021 14:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617115892;
        bh=jQvBFhkZ2SR0hSEovncl3Olh0doa2fgmumWI1v2bnwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ym0XbF9jJwHKpaRE0p4tw4acwA7QutOSOEIVbwqhlFlx5MG7eyf2HZlpN23Q8Fmx/
         cKx7EkjpBfv07MDOczh7b/OfKT+xp2UyP1hFlDhc3CLQdnkZ7Z5SEyElDk7SbeDW/B
         gffCqYmoOuWSsy99q/ZJ/JMbCWsmnyI3DwBXKbXM=
Date:   Tue, 30 Mar 2021 16:51:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: Re: [PATCH v1 1/4] docs: make reporting-issues.rst official and
 delete reporting-bugs.rst
Message-ID: <YGM68Q0+aeNgjsdy@kroah.com>
References: <cover.1617113469.git.linux@leemhuis.info>
 <49c674c2d304d87e6259063580fda05267e8c348.1617113469.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49c674c2d304d87e6259063580fda05267e8c348.1617113469.git.linux@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 04:13:04PM +0200, Thorsten Leemhuis wrote:
> Removing Documentation/admin-guide/reporting-bugs.rst will break links
> in some of the translations. I was unsure if simply changing them to
> Documentation/admin-guide/reporting-issue.rst was wise, so I didn't
> touch anything for now and CCed the maintainers for the Chinese and
> Italian translation. I couldn't find one for the Japanse translation.
> 
> Please advice. For completeness, this are the places where things will
> break afaics:
> 
> $ grep -ri 'reporting-bugs.rst' Documentation/
> Documentation/translations/zh_CN/SecurityBugs:是有帮助的信息，那就请重温一下admin-guide/reporting-bugs.rst文件中的概述过程。任
> Documentation/translations/zh_CN/process/howto.rst:内核源码主目录中的:ref:`admin-guide/reporting-bugs.rst <reportingbugs>`
> Documentation/translations/zh_CN/admin-guide/reporting-issues.rst:   本文档将取代“Documentation/admin-guide/reporting-bugs.rst”。主要的工作
> Documentation/translations/zh_CN/admin-guide/reporting-issues.rst:   “Documentation/admin-guide/reporting-bugs.rst”中的旧文字非常相似。它和它
> Documentation/translations/it_IT/process/howto.rst:Il file admin-guide/reporting-bugs.rst nella cartella principale del kernel
> Documentation/translations/ja_JP/howto.rst:admin-guide/reporting-bugs.rstはカーネルバグらしいものについてどうレポー

Traditionally translations catch up much later on, you shouldn't have to
worry about them the authors will clean them up and submit patches for
them when they get the chance.

thanks,

greg k-h
