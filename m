Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D597830F5AB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbhBDO5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:57:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58761 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236979AbhBDOz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612450441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b9HITKexMMicmXiHQei2OWps7zUA5ydgph9fKXq5FwY=;
        b=YmKCugyystb3rSbUo5g3IS4TDUAIWN7Cczc8kkhDwcovuowPLAOLiVhtOvg9dlvz8kNgMB
        un/fnHHUBFsvoMpHJgQVmDrkma1I+SF6w7kcBTPh4dnoT5yvwx8FqWT/VJ3kExmcJ7uVGY
        diTvgKaFPLmThkdQTFyO30a4sKdHGJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-qhwPUz1lN1GS-6ZdSPsttg-1; Thu, 04 Feb 2021 09:53:59 -0500
X-MC-Unique: qhwPUz1lN1GS-6ZdSPsttg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47FF6100C614;
        Thu,  4 Feb 2021 14:53:56 +0000 (UTC)
Received: from krava (unknown [10.40.194.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id A8C6817D8C;
        Thu,  4 Feb 2021 14:53:53 +0000 (UTC)
Date:   Thu, 4 Feb 2021 15:53:52 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 18/24] perf daemon: Add man page for perf-daemon
Message-ID: <YBwKgE60VzrHE1rz@krava>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-19-jolsa@kernel.org>
 <20210203211715.GV854763@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203211715.GV854763@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 06:17:15PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, Jan 31, 2021 at 12:48:50AM +0100, Jiri Olsa escreveu:
> > Adding man page for perf-daemon usage.
> 
> I see you decided to add it at the end, but for consistency, please
> consider adding the bare minimum when adding
> tools/perf/builtin-daemon.c, then go on adding the options and examples
> as the features are being added.

sure, will change

thanks,
jirka

