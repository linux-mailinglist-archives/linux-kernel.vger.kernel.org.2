Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FA139B9CE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 15:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhFDN1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhFDN1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:27:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBAFA613F8;
        Fri,  4 Jun 2021 13:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622813114;
        bh=LtbiouFhlRH/xN8uoJX0vAXnOnmmKhBcN2uF6UK1/y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QzhU1t/yPTo1gh22Yb9jacCFlJj43frs+JaYk3fPtCECsI4S3wSKvPrOvUwceC20Y
         9LX13zt0im+lA4+4YFJcbXdmv7qr3agxvjaCClbIMG7fyx31bMk06v3Pc783giEX/h
         txXTEOay+qiyg/OJmuQ+63+3zmfzbVi/P/XrTMCUOz4Domrk/XdOejfL+aOlm/TNRy
         4g1o4OmjFWaOUx+qG15B6/L2kB6EwtfXsyyyNKV3aQN7hYgKqteWIK9EtkZdeJ4/gY
         2abwGSQkv44z8GPq3RmLhc20lwa1bhVm690vj0so8EOOos9+/HMiMuoUynW23eH9Iq
         9xMelhSdL93hA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7C1DE40EFC; Fri,  4 Jun 2021 10:25:11 -0300 (-03)
Date:   Fri, 4 Jun 2021 10:25:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, jolsa@redhat.com,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v2] tools/perf: doc: Add permission and sysctl notice
Message-ID: <YLoptykPzLOOVKfo@kernel.org>
References: <162201967838.287555.4257117900130102987.stgit@devnote2>
 <162204068898.388434.16842705842611255787.stgit@devnote2>
 <YLdxL9QVh5n6xGeP@kernel.org>
 <e12e3fcb-15a7-42c3-7994-2fc9e8b854a1@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e12e3fcb-15a7-42c3-7994-2fc9e8b854a1@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 02, 2021 at 07:21:34PM +0530, Ravi Bangoria escreveu:
> 
> 
> On 6/2/21 5:23 PM, Arnaldo Carvalho de Melo wrote:
> > Em Wed, May 26, 2021 at 11:51:29PM +0900, Masami Hiramatsu escreveu:
> > > Add a section to notify the permission and sysctl setting
> > > for perf probe. And fix some indentations.
> > > 
> > > Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > 
> > Ravi, can I have your Reviewed-by?
> 
> Yes please. Thanks for checking.
> 
> Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Thanks, applied.

- Arnaldo

