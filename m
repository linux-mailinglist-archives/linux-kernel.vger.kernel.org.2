Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD20231F375
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 01:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhBSAzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 19:55:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:60570 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhBSAzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 19:55:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 996CCABAE;
        Fri, 19 Feb 2021 00:54:23 +0000 (UTC)
Date:   Fri, 19 Feb 2021 01:54:23 +0100
From:   Jiri Bohac <jbohac@suse.cz>
To:     Kees Cook <keescook@chromium.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: pstore: fix compression
Message-ID: <20210219005423.p2y5ob6637pp245n@dwarf.suse.cz>
References: <20210218111547.johvp5klpv3xrpnn@dwarf.suse.cz>
 <161368019685.305632.7880211837303066992.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161368019685.305632.7880211837303066992.b4-ty@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 12:30:03PM -0800, Kees Cook wrote:
> Eek; thanks for the catch!

thanks for applying the fix;

BTW, with the compression broken, I was not getting any dmesg
stored in ERST at all, not even uncompressed. After instrumenting
the code with a lot of debug printks I found that writing
erst_erange.size worth of data into the ERST fails and the
maximum writeable size is 98 bytes smaler:

Details: 

	- erst_erange.size = 65536
	- this results in  erst_info.bufsize = 65336
	- pstore_compress() returned -EINVAL (because of the
	  just-fixed typo), zipped_len = -EINVAL.
	- pstore_dump calls copy_kmsg_to_buffer to only copy bufsize
	  bytes from big_oops_buf to psinfo->buf;
	  record.size = bufsize = 65336

	psinfo->write(&record) then fails with -EINVAL;
	by more tracing inside the ERST code I found the -EINVAL was
	produced by __erst_write_to_storage()
	after apei_exec_ctx_get_output() returned
	val=ERST_STATUS_FAILED=3 and this got translated into -EINVAL by
	erst_errno().

	Once the compression was fixed everything started working because
	the records are much smaller after the compression (~30kB).

	My next thought was to find the largest possible record that
	could be written successfully.
	I modified the ERST init code to decrease erst_info.bufsize by a
	value specified on the cmdline. The maximum writable record was
	65238 bytes long (i.e. erst_erange.size - sizeof(struct
	cper_pstore_record) - 98). With this hack I got
	65238 bytes of uncompressed dmesg stored to ERST.

Any idea what might be causing this?
As far as I can tell, there are no other records in the ERST
(checked through the erst-dbg interface).
Tested on a HPE ProLiant DL120 Gen10 server.

Thanks!


-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia

