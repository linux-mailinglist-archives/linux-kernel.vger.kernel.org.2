Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14C536734B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242914AbhDUTSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:18:33 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:34098 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241659AbhDUTSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:18:31 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lZIME-004DZE-Pl; Wed, 21 Apr 2021 13:17:55 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lZIMD-00AtxS-Q9; Wed, 21 Apr 2021 13:17:54 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Andrew G. Morgan" <morgan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        security@kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Andy Lutomirski <luto@kernel.org>
References: <20210416045851.GA13811@mail.hallyn.com>
        <20210416150501.zam55gschpn2w56i@wittgenstein>
        <20210416213453.GA29094@mail.hallyn.com>
        <20210417021945.GA687@mail.hallyn.com>
        <20210417200434.GA17430@mail.hallyn.com>
        <20210419122514.GA20598@mail.hallyn.com>
        <20210419160911.5pguvpj7kfuj6rnr@wittgenstein>
        <20210420034208.GA2830@mail.hallyn.com>
        <20210420083129.exyn7ptahx2fg72e@wittgenstein>
        <20210420134334.GA11582@mail.hallyn.com>
Date:   Wed, 21 Apr 2021 14:16:34 -0500
In-Reply-To: <20210420134334.GA11582@mail.hallyn.com> (Serge E. Hallyn's
        message of "Tue, 20 Apr 2021 08:43:34 -0500")
Message-ID: <m15z0fphwt.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lZIMD-00AtxS-Q9;;;mid=<m15z0fphwt.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18G0AOfV6rwW+2m4+vJWzKrMcLT6wolZpc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4906]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;"Serge E. Hallyn" <serge@hallyn.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 465 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (2.5%), b_tie_ro: 10 (2.1%), parse: 1.78
        (0.4%), extract_message_metadata: 18 (3.9%), get_uri_detail_list: 2.5
        (0.5%), tests_pri_-1000: 5 (1.2%), tests_pri_-950: 1.34 (0.3%),
        tests_pri_-900: 1.11 (0.2%), tests_pri_-90: 58 (12.4%), check_bayes:
        56 (12.1%), b_tokenize: 8 (1.8%), b_tok_get_all: 7 (1.5%),
        b_comp_prob: 2.3 (0.5%), b_tok_touch_all: 35 (7.6%), b_finish: 0.86
        (0.2%), tests_pri_0: 350 (75.4%), check_dkim_signature: 0.75 (0.2%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 0.42 (0.1%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 11 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3.4] capabilities: require CAP_SETFCAP to map uid 0
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serge@hallyn.com> writes:

> +/**
> + * verify_root_map() - check the uid 0 mapping
> + * @file: idmapping file
> + * @map_ns: user namespace of the target process
> + * @new_map: requested idmap
> + *
> + * If a process requests mapping parent uid 0 into the new ns, verify that the
> + * process writing the map had the CAP_SETFCAP capability as the target process
> + * will be able to write fscaps that are valid in ancestor user namespaces.
> + *
> + * Return: true if the mapping is allowed, false if not.
> + */
> +static bool verify_root_map(const struct file *file,
> +			    struct user_namespace *map_ns,
> +			    struct uid_gid_map *new_map)
> +{
> +	int idx;
> +	const struct user_namespace *file_ns = file->f_cred->user_ns;
> +	struct uid_gid_extent *extent0 = NULL;
> +
> +	for (idx = 0; idx < new_map->nr_extents; idx++) {
> +		if (new_map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
> +			extent0 = &new_map->extent[idx];
> +		else
> +			extent0 = &new_map->forward[idx];
> +		if (extent0->lower_first == 0)
> +			break;
> +
> +		extent0 = NULL;
> +	}
> +
> +	if (!extent0)
> +		return true;
> +
> +	if (map_ns == file_ns) {
> +		/* The process unshared its ns and is writing to its own
> +		 * /proc/self/uid_map.  User already has full capabilites in
> +		 * the new namespace.  Verify that the parent had CAP_SETFCAP
> +		 * when it unshared.
> +		 * */
> +		if (!file_ns->parent_could_setfcap)
> +			return false;
> +	} else {
> +		/* Process p1 is writing to uid_map of p2, who is in a child
> +		 * user namespace to p1's.  Verify that the opener of the map
> +		 * file has CAP_SETFCAP against the parent of the new map
> +		 * namespace */
> +		if (!file_ns_capable(file, map_ns->parent, CAP_SETFCAP))
> +			return false;
> +	}

Is there any reason this permission check is not simply:

	return map_ns->parent_could_setfcap ||
               file_ns_capable(file, map_ns->parent, CAP_SETFCAP);

That is why don't we allow any mapping (that is otherwise valid) in user
namespaces whose creator had the permission to call CAP_SETFCAP?

Why limit the case of using the creators permissions to only the case of
mapping just a single uid (that happens to be the current euid) in the
user namespace?

I don't see any safety reasons for the map_ns == file_ns test.



Is the file_ns_capable check for CAP_SETFCAP actually needed?  AKA could
the permission check be simplified to:

	return map_ns->parent_could_setfcap;

That would be a much easier rule to explain to people.

I seem to remember distributions at least trying to make newuidmap have
just CAP_SETUID and newgidmap have just CAP_SETGID.  Such a simplified
check would facilitate that.

Eric
