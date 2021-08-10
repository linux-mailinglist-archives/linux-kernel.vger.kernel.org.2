Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0E93E830A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 20:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhHJSdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 14:33:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232947AbhHJSdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 14:33:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 889EA60E76;
        Tue, 10 Aug 2021 18:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628620368;
        bh=/LrJ/rq0CvD6CnWWZdSl3uTazUfjxuJdjIxBNxC87dU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u+tmwFMs2N9nEyK4gKnC0EsVmu25b7Ocym1jsuYFRE+HJ06DOIogQTgdFtTShl67H
         8/vwyCPCQm/3Xe++aZaLK8JAkLHOpBialnn+2P5j0jb9LHd5Dm/8jeg+ONAGJ/LmUk
         1FlOaOj3nqAB8Fbkv9VHHRTkJIdr8ydcEUT55tccDubh9iVrS9sJikPZeYc6SpJ2g7
         ks4wO86J1SR+qD8zjpxFF1eqV36J16tlrBuH+/bQDSyuOgOFs1iszDFEfiupTriV8F
         4k7oeGfbIHBXuIpPOdaJq8vqqdxHOJC2PDa8Dy/+N55rqfiKKRwCB4tXMBQRWbe/aT
         +F9Wcbv3x5gDA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2C196403F2; Tue, 10 Aug 2021 15:32:45 -0300 (-03)
Date:   Tue, 10 Aug 2021 15:32:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] perf tools: Add dlfilter test
Message-ID: <YRLGTfQdg7pBcf29@kernel.org>
References: <20210810114813.12951-1-adrian.hunter@intel.com>
 <20210810114813.12951-6-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810114813.12951-6-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 10, 2021 at 02:48:13PM +0300, Adrian Hunter escreveu:
> Add a perf test to test the dlfilter C API.
> 
> A perf.data file is synthesized and then processed by perf script with a
> dlfilter named dlfilter-test-api-v0.so. Also a C file is compiled to
> provide a dso to match the synthesized perf.data file.

[root@five ~]# perf test dlfilter
72: dlfilter C API                                                  : FAILED!
[root@five ~]# perf test -v dlfilter
72: dlfilter C API                                                  :
--- start ---
test child forked, pid 3358542
Checking for gcc
Command: gcc --version
gcc (GCC) 11.1.1 20210531 (Red Hat 11.1.1-3)
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

dlfilters path: /var/home/acme/libexec/perf-core/dlfilters
Command: gcc -g -o /tmp/dlfilter-test-3358542-prog /tmp/dlfilter-test-3358542-prog.c
Creating new host machine structure
Command: /var/home/acme/bin/perf script -i /tmp/dlfilter-test-3358542-perf-data --dlfilter /var/home/acme/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so --dlarg first --dlarg 1 --dlarg 4198669 --dlarg 4198662 --dlarg 0 --dlarg last
Failed with return value 139
test child finished with -1
---- end ----
dlfilter C API: FAILED!
[root@five ~]# cat /etc/redhat-release
Fedora release 34 (Thirty Four)
[root@five ~]# cat /etc/os-release
NAME=Fedora
VERSION="34.20210721.0 (Silverblue)"
ID=fedora
VERSION_ID=34
VERSION_CODENAME=""
PLATFORM_ID="platform:f34"
PRETTY_NAME="Fedora 34.20210721.0 (Silverblue)"
ANSI_COLOR="0;38;2;60;110;180"
LOGO=fedora-logo-icon
CPE_NAME="cpe:/o:fedoraproject:fedora:34"
HOME_URL="https://fedoraproject.org/"
DOCUMENTATION_URL="https://docs.fedoraproject.org/en-US/fedora-silverblue/"
SUPPORT_URL="https://fedoraproject.org/wiki/Communicating_and_getting_help"
BUG_REPORT_URL="https://bugzilla.redhat.com/"
REDHAT_BUGZILLA_PRODUCT="Fedora"
REDHAT_BUGZILLA_PRODUCT_VERSION=34
REDHAT_SUPPORT_PRODUCT="Fedora"
REDHAT_SUPPORT_PRODUCT_VERSION=34
PRIVACY_POLICY_URL="https://fedoraproject.org/wiki/Legal:PrivacyPolicy"
VARIANT="Silverblue"
VARIANT_ID=silverblue
OSTREE_VERSION='34.20210721.0'
[root@five ~]#

Trying to figure this out...

- Arnaldo
