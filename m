Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92AD3DEDF9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbhHCMkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:40:24 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.129]:34514 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235721AbhHCMkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:40:18 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id B65717DD5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 07:40:06 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id AtiImlmXxMGeEAtiImxD94; Tue, 03 Aug 2021 07:40:06 -0500
X-Authority-Reason: nr=8
Received: from host-95-239-202-226.retail.telecomitalia.it ([95.239.202.226]:38642 helo=x1.bristot.me)
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1mAtiH-0049qA-RO; Tue, 03 Aug 2021 07:40:06 -0500
Subject: Re: [PATCH v2 12/21] libtracefs; Add error message for bad selections
 to SQL sequence
To:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
References: <20210803042347.679499-1-rostedt@goodmis.org>
 <20210803042347.679499-13-rostedt@goodmis.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
Message-ID: <f4fc1e3d-2383-f5d3-3938-0e131bf623cb@kernel.org>
Date:   Tue, 3 Aug 2021 14:40:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803042347.679499-13-rostedt@goodmis.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 95.239.202.226
X-Source-L: No
X-Exim-ID: 1mAtiH-0049qA-RO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-239-202-226.retail.telecomitalia.it (x1.bristot.me) [95.239.202.226]:38642
X-Source-Auth: kernel@bristot.me
X-Email-Count: 3
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/21 6:23 AM, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 

there is a ; in the subject... "libtracefs;"

-- Daniel
