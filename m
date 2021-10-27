Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E662A43D153
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 20:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbhJ0TCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 15:02:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230073AbhJ0TCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 15:02:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86A2360296;
        Wed, 27 Oct 2021 18:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635361177;
        bh=ZXRY1gkuzpr9oLiFHBPFmFs6bk8AIH8zWvEmikhnYlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ARwvhWyAna5o+kzLitB0tGnOuUP0Jr3f8EF5ppB2C9i8YUeh4ATpxw7CqUtZopI3g
         HK9lBiUlLB36mQU89n7CJRq0nEyREy4HUUHycoPFANQCdf1HmVS3Q660nMQ5L9EBBn
         7zG3RdBnpPjqU2C10mrxWMDB6hbptRMwr/oOdz+TvvPUn1UFpOFyWp9lQalgEg/G4k
         008rWI1HpQcIGe4yGgnlGAc3whOEFSLco/99aZxf/1xaSlStiMHr9uXxjIxj+KsgTE
         qdwrt4/rvD6HJjvxlFwI50s4s9xPhbBawAWQ8DK8mlwAItEou9JrqAyzGqCAMZCrkC
         na4r6CD8xpyBQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C8978410A1; Wed, 27 Oct 2021 15:59:34 -0300 (-03)
Date:   Wed, 27 Oct 2021 15:59:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 6/6] perf intel-pt: Support itrace d+o option to
 direct debug log to stdout
Message-ID: <YXmhljlSIjkA6hqL@kernel.org>
References: <20211026090152.357591-1-adrian.hunter@intel.com>
 <20211026090152.357591-7-adrian.hunter@intel.com>
 <dd9f91af-8b74-bf75-b3a4-c3826be7b190@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd9f91af-8b74-bf75-b3a4-c3826be7b190@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 26, 2021 at 10:05:15AM -0700, Andi Kleen escreveu:
> Except for the documentation comments everything looks good to me. Thanks
> for implementing that.
> 
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Thanks, he can send the expansion on a follow up patch, reviewing and
applying.

- Arnaldo
