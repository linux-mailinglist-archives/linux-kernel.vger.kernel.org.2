Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D5335D2E7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 00:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343625AbhDLWKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 18:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbhDLWKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 18:10:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AA5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=zgCj7jNZerYzvW/AwakU+vlTz4aSYpdA0R6kvdcCgqw=; b=VfhFLsRJwf3jHXIktOHBsExsjx
        C33CwWD7bq+HWvO15UOMYWFAqP2MGSfy4MZE5u6iXTBfV4j/+6t1ebWdPYh9qLjCU/vTJLrTTnNr6
        2LAAh15wBxL+RdmWfcPqcZKF24MLCu586AV1ip28wuMO98fkzz0yhkEnuwI/Mt5JaU/fILXeFj/yb
        GaovcRHh7Qwn568/MDWqZsff0otfFo5G0Ad4oRdKbiWtZd4ksLTeOzqXtuwVBC6PUTkfnBmFhFikh
        UeFzyeZz0WdZfy9Jqz3aWEvGchxXp0boJEEL9gfNBaMqRn09IoNsuU1Dkiudahxe/xNEXF6l+wrqv
        U6ughARA==;
Received: from [2601:1c0:6280:3f0::e0e1]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lW4kb-007lO3-TC; Mon, 12 Apr 2021 22:09:46 +0000
To:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: x86: report: write to unrecognized MSR
Message-ID: <12997c36-8e18-87fc-2e49-bf40c14db2d7@infradead.org>
Date:   Mon, 12 Apr 2021 15:09:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[   27.075563] msr: Write to unrecognized MSR 0x1b0 by x86_energy_perf (pid: 1223).
[   27.078979] msr: See https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/about for details.

(aka x86_energy_perf_policy)


on linux-next-20210409 / x86_64.

-- 
~Randy

